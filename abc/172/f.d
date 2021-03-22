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

alias P = Tuple!(long, long, long, bool);

void main()
{
    int N; get(N);
    long[] AS; get(AS);

    long S;
    if (N > 2) S = AS[2];
    if (N > 3) foreach (a; AS[3..$]) S ^= a;

    long[P] DP;
    long solve(long a, long b, long s, bool f) {
        if (a == 0) return (f && b == s) ? 0 : -1;

        auto t = P(a, b, s, f);
        if (t in DP) return DP[t];

        long res = -1;
        if (((a ^ b) & 1) == (s & 1)) {
            auto r = solve(a >> 1, b >> 1, s >> 1, f || !!(a & 1));
            if (r != -1) {
                r <<= 1;
                if (res == -1) res = r;
                res = min(res, r);
            }
        }
        if ((((a - 1) ^ (b + 1)) & 1) == (s & 1)) {
            auto r = solve((a - 1) >> 1, (b + 1) >> 1, s >> 1, f || !(a & 1));
            if (r != -1) {
                r = (r << 1) | 1;
                if (res == -1) res = r;
                res = min(res, r);
            }
        }
        return DP[t] = res;
    }
    writeln(solve(AS[0], AS[1], S, false));
}

/*

x B + x B * x B
1 1 1 1 0 0 0 0
1 1 0 0 1 1 0 0
1 0 1 0 1 0 1 0

A_1, A_2, A_3, ..., A_n

S = A_3 ^ A_4 ^ ... ^ A_n

x を移動させる数として、

(A_1 - x) ^ (A_2 + x) = S
となる x を求める事


0100000000000000000000000000000001
1000000000000000000000000000000001

1100000000000000000000000000000010

*/
