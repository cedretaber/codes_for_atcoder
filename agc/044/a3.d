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

import std.bigint;

void main()
{
    int T; get(T); while (T--) {
        long N, A, B, C, D; get(N, A, B, C, D);
        auto n = BigInt(N);
        auto a = BigInt(A);
        auto b = BigInt(B);
        auto c = BigInt(C);
        auto d = BigInt(D);
        BigInt[BigInt] cs;
        BigInt solve(BigInt n) {
            if (n == 0) return BigInt(0);
            if (n == 1) return d;
            if (n == 2) return min(a + d, d * 2);
            if (n !in cs) {
                cs[n] = min(d * n, solve(n / 2) + a + n % 2 * d, solve(n / 2 + 1) + a + (2 - n % 2) * d);
                if (n >= 3) cs[n] = min(cs[n], solve(n / 3) + b + n % 3 * d, solve(n / 3 + 1) + b + (3 - n % 3) * d);
                if (n >= 5) cs[n] = min(cs[n], solve(n / 5) + c + n % 5 * d, solve(n / 5 + 1) + c + (5 - n % 5) * d);
            }
            return cs[n];
        }
        writeln(solve(n));
    }
}
