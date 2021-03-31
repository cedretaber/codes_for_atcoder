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

import core.bitop;

void main()
{
    for (;;) {
        int N, A, B; get(N, A, B);
        if (N == 0) return;

        int[] XS; get(XS);

        auto DP = new long[](1 << N);
        DP[] = -1;
        long solve(uint s) {
            if (popcnt(s) <= 1) return 1;
            if (DP[s] != -1) return DP[s];

            long r;
            foreach (p; 0..N) if ((1<<p) & s) {
                auto m = s & ~(1<<p);
                auto x = (m - 1) & m;
                while (x) {
                    int a, b;
                    foreach (i; 0..N) if ((1<<i) & m) {
                        if ((1<<i) & x) {
                            a += XS[i];
                        } else {
                            b += XS[i];
                        }
                    }
                    if (A <= abs(a - b) && abs(a - b) <= B) r += solve(x) * solve(m & ~x);
                    x = (x - 1) & m;
                }
                int n;
                foreach (i; 0..N) if ((1<<i) & m) n += XS[i];
                if (A <= n && n <= B) r += solve(m) * 2;
            }
            return DP[s] = r;
        }
        writeln(solve((1<<N) - 1));
    }
}
