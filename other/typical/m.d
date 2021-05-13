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

alias P = Tuple!(int, "to", long, "c");

void main()
{
    int N, M; get(N, M);
    auto G = new P[][N];
    while (M--) {
        int A, B; long C; get(A, B, C); --A; --B;
        G[A] ~= P(B, C);
        G[B] ~= P(A, C);
    }

    auto Q = heapify!"a.c > b.c"([P(0, 0)]);
    void run(ref long[] DP) {
        while (!Q.empty) with (Q.front) {
            Q.popFront();
            foreach (n; G[to]) if (DP[n.to] > c + n.c) {
                DP[n.to] = c + n.c;
                Q.insert(P(n.to, c + n.c));
            }
        }
    }
    auto SS = new long[](N);
    SS[] = long.max / 3; SS[0] = 0;
    run(SS);
    Q = heapify!"a.c > b.c"([P(N - 1, 0)]);
    auto TS = new long[](N);
    TS[] = long.max / 3; TS[N - 1] = 0;
    run(TS);
    foreach (i; 0..N) writeln(SS[i] + TS[i]);
}
