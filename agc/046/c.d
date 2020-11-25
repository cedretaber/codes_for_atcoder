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

enum P = 998244353L;

void main()
{
    char[] S; int K; get(S, K);
    int[] ss;
    int s, m;
    foreach (c; S) {
        if (c == '1') {
            ++m;
            ++s;
        } else {
            ss ~= s;
            s = 0;
        }
    }
    ss ~= s;

    auto DP = new long[][][](ss.length, m + 1, m + 1);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = -1;
    long solve(int i, int r, int c) {
        if (i == ss.length) return r == 0 ? 1 : 0;
        if (DP[i][r][c] == -1) {
            long x;
            foreach (d; 1..min(ss[i], r)+1) {
                (x += solve(i+1, r - d, c)) %= P;
            }
            (x += solve(i+1, r, c)) %= P;
            foreach (e; 1..c+1) {
                (x += solve(i+1, r + e, c - e)) %= P;
            }
            DP[i][r][c] = x;
        }
        return DP[i][r][c];
    }
    writeln(solve(0, 0, min(m, K)));
}

/*

0101

0 1 1

1 0 0
0 2 0
1 1 0

今まで何本動かしたか / 残り動かさないといけないのは何本か

*/