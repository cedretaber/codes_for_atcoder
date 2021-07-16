import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

void main()
{
    int N, M, Q; get(N, M, Q);
    alias P = Tuple!(int, "to", long, "c");
    auto G = new P[][N];
    while (M--) {
        int A, B, C; get(A, B, C); --A; --B;
        G[A] ~= P(B, C);
        G[B] ~= P(A, C);
    }
    int[] XS; get(XS);

    auto memo = new bool[](N);
    memo[0] = true;
    int cnt = 1;
    auto ps = heapify!"a.c > b.c"([P(-1, int.max)]);
    foreach (p; G[0]) ps.insert(p);
    foreach (x; XS) {
        P[] qs;
        while (ps.front.c <= x) {
            auto p = ps.front;
            ps.popFront();
            if (!memo[p.to]) {
                memo[p.to] = true;
                ++cnt;
                foreach (q; G[p.to]) if (!memo[q.to]) qs ~= q;
            }
        }
        foreach (q; qs) ps.insert(q);
        writeln(cnt);
    }
}
