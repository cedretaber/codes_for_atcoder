import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import std.bigint;

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

BigInt solve(BigInt n, BigInt a, BigInt b, BigInt c, BigInt d)
{
    BigInt[BigInt] DP;
    BigInt impl(BigInt x) {
        if (x <= 1) return x == BigInt("1") ? d : BigInt("0");
        if (x == 2) return min(d * 2, a + d);

        if (x !in DP) {
            DP[x] = min(
                x * d,
                impl(x / 2) + a + x % 2 * d,
                impl(x / 2 + 1) + a + (2 - x % 2) * d,
                impl(x / 3) + b + x % 3 * d,
                impl(x / 3 + 1) + b + (3 - x % 3) * d,
                impl(x / 5) + c + x % 5 * d,
                impl(x / 5 + 1) + c + (5 - x % 5) * d
            );
        }
        return DP[x];
    }
    return impl(n);
}

void main()
{
    int T; get(T);
    while (T--) {
        string n, a, b, c, d; get(n, a, b, c, d);
        writeln(solve(BigInt(n), BigInt(a), BigInt(b), BigInt(c), BigInt(d)));
    }
}