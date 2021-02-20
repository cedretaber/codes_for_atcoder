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
    int N, M; get(N, M);
    alias P = Tuple!(int, "i", int, "to");
    auto G = new P[][N];
    auto RG = new P[][N];
    foreach (i; 0..M) {
        int s, t; get(s, t); --s; --t;
        G[s] ~= P(i, t);
        RG[t] ~= P(i, s);
    }
    alias V = Tuple!(int, "i", double, "e");
    auto vs = 0.iota(M).map!(i => V(i, 0)).array();

    auto DP = new double[](N);
    DP[] = 0;
    foreach_reverse (i; 0..N) {
        if (G[i].length) DP[i] /= G[i].length;
        foreach (p; RG[i]) {
            vs[p.i].e = DP[i] + 1;
            DP[p.to] += DP[i] + 1;
        }
    }
    auto res = DP[0];
    foreach (x; 0..N-1) {
        DP[] = 0;
        foreach_reverse (i; 0..N) {
            if (i == x && G[i].length > 1) {
                sort!((a, b) => vs[a.i].e > vs[b.i].e)(G[i]);
                DP[i] = (DP[i] - vs[G[i].front.i].e) / (G[i].length - 1);
            } else {
                if (G[i].length) DP[i] /= G[i].length;
            }
            foreach (p; RG[i]) DP[p.to] += DP[i] + 1;
        }
        res = min(res, DP[0]);
    }
    writefln!"%.12f"(res);
}

/*

4 6
1 4
3 4
2 4
2 3
1 3
// 1 2

4: 0
3: 1 / 1 = 1
2: 1 + 2 / 3 = 1.5
1: 1 + 2 / 3 = 1.5

*/