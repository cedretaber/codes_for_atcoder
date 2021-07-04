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
    char[] N; long K; get(N, K);

    auto next = new Tuple!(int, int, int, int)[](10);
    foreach (P; 1..10) {
        int p = P, p2, p3, p5, p7;
        while (p % 2 == 0) {
            ++p2;
            p /= 2;
        }
        while (p % 3 == 0) {
            ++p3;
            p /= 3;
        }
        if (p % 5 == 0) ++p5;
        if (p % 7 == 0) ++p7;

        next[P] = tuple(p2, p3, p5, p7);
    }

    auto DP = new long[][][][][][][](N.length + 1, 2, 2, 55, 37, 19, 19);
    long s0, s0u;
    foreach (i; 0..N.length) {
        int d = N[i] - '0';
        if (i == 0) {
            foreach (p; 1..d) {
                auto x = next[p];
                DP[i + 1][0][0][x[0]][x[1]][x[2]][x[3]] += 1;
            }
            auto x = next[d];
            DP[i + 1][1][0][x[0]][x[1]][x[2]][x[3]] += 1;
        } else {
            foreach (p; 1..10) {
                auto x = next[p];
                DP[i + 1][0][0][x[0]][x[1]][x[2]][x[3]] += 1;
            }
        }
        foreach (i2; 0..55) foreach (i3; 0..37) foreach (i5; 0..19) foreach (i7; 0..19) {
            if (DP[i][0][0][i2][i3][i5][i7] ||DP[i][0][1][i2][i3][i5][i7]) {
                DP[i + 1][0][1][i2][i3][i5][i7] += DP[i][0][0][i2][i3][i5][i7] + DP[i][0][1][i2][i3][i5][i7];
                foreach (p; 1..10) {
                    auto x = next[p];
                    DP[i + 1][0][0][i2 + x[0]][i3 + x[1]][i5 + x[2]][i7 + x[3]] += DP[i][0][0][i2][i3][i5][i7];
                    DP[i + 1][0][1][i2 + x[0]][i3 + x[1]][i5 + x[2]][i7 + x[3]] += DP[i][0][1][i2][i3][i5][i7];
                }
            }
            if (DP[i][1][0][i2][i3][i5][i7] || DP[i][1][1][i2][i3][i5][i7]) {
                if (d > 0) {
                    auto x = next[d];
                    DP[i + 1][1][0][i2 + x[0]][i3 + x[1]][i5 + x[2]][i7 + x[3]] += DP[i][1][0][i2][i3][i5][i7];
                    DP[i + 1][1][1][i2 + x[0]][i3 + x[1]][i5 + x[2]][i7 + x[3]] += DP[i][1][1][i2][i3][i5][i7];
                    DP[i + 1][0][1][i2][i3][i5][i7] += DP[i][1][0][i2][i3][i5][i7] + DP[i][1][1][i2][i3][i5][i7];
                } else {
                    DP[i + 1][1][1][i2][i3][i5][i7] += DP[i][1][0][i2][i3][i5][i7] + DP[i][1][1][i2][i3][i5][i7];
                }
                foreach (p; 1..d) {
                    auto x = next[p];
                    DP[i + 1][0][0][i2 + x[0]][i3 + x[1]][i5 + x[2]][i7 + x[3]] += DP[i][1][0][i2][i3][i5][i7];
                    DP[i + 1][0][1][i2 + x[0]][i3 + x[1]][i5 + x[2]][i7 + x[3]] += DP[i][1][1][i2][i3][i5][i7];
                }
            }
        }
    }

    long res;
    foreach (i2; 0..55) foreach (i3; 0..37) foreach (i5; 0..19) foreach (i7; 0..19) {
        res += DP[N.length][0][1][i2][i3][i5][i7] + DP[N.length][1][1][i2][i3][i5][i7];
        if (DP[N.length][0][0][i2][i3][i5][i7] || DP[N.length][1][0][i2][i3][i5][i7]) {
            if (2L ^^ i2 * 3L ^^ i3 * 5L ^^ i5 * 7L ^^ i7 <= K) {
                res += DP[N.length][0][0][i2][i3][i5][i7] + DP[N.length][1][0][i2][i3][i5][i7];
            }
        }
    }
    writeln(res);
}
