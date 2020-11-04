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

alias P = Tuple!(int, "i", int, "p");
alias E = Tuple!(int, "i", long, "d");
alias S = Tuple!(int, "i", int, "s", long, "t");

void main()
{
    int M, N, K; get(M, N, K);
    auto XY = new P[][10^^5][2];
    int start = -1, end = -1;
    foreach (i; 0..K) {
        int x, y; get(x, y);
        if (x == 1 && y == 1) {
            start = i+1;
        } else if (x == M && y == N) {
            end = i+1;
        }
        XY[0][x-1] ~= P(i+1, y-1);
        XY[1][y-1] ~= P(i+1, x-1);
    }
    {
        if (start == -1) {
            XY[0][0] ~= P(0, 0);
            XY[1][0] ~= P(0, 0);
            start = 0;
        }
        if (end == -1) {
            XY[0][M-1] ~= P(K+1, N-1);
            XY[1][N-1] ~= P(K+1, M-1);
            end = K+1;
        }
    }
    auto GG = [new E[][K+2], new E[][K+2]];
    static foreach (g; 0..2) foreach (ss; XY[g]) if (ss.length > 1) {
        sort!"a.p < b.p"(ss);
        foreach (i; 0..ss.length) {
            auto x = ss[i];
            if (i) {
                auto w = ss[i-1];
                GG[g][x.i] ~= E(w.i, x.p - w.p);
            }
            if (i+1 < ss.length) {
                auto y = ss[i+1];
                GG[g][x.i] ~= E(y.i, y.p - x.p);
            }
        }
    }

    auto DP = new long[][](K+2, 2);
    foreach (ref dp; DP) dp[] = long.max/3;
    auto Q = heapify!"a.t > b.t"([S(start, 0, 0)]);
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        auto ss = (s+1)%2;
        if (i != 0 && i != K+1 && DP[i][ss] > t + 1) {
            DP[i][ss] = t + 1;
            Q.insert(S(i, ss, t + 1));
        }
        foreach (v; GG[s][i]) if (DP[v.i][s] > t + v.d) {
            DP[v.i][s] = t + v.d;
            Q.insert(S(v.i, s, t + v.d));
        }
    }
    auto res = DP[end].minElement;
    writeln(res == long.max/3 ? -1 : res);
}