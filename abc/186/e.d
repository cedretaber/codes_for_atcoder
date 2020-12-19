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

Tuple!(long, long, long) ext_gcd(long a, long b)
{
    if (b == 0) {
        return tuple(1L, 0L, a);
    }
    auto res = ext_gcd(b, a % b);
    auto y = res[0];
    auto x = res[1];
    auto d = res[2];
    return tuple(x, y - (a / b) * x, d);
}

void main()
{
    int T; get(T);
    while (T--) {
        long N, S, K; get(N, S, K); K %= N;
        auto d = gcd(N, K);
        if (S % d != 0) {
            writeln(-1);
            continue;
        }
        N /= d;
        K /= d;
        auto r = ext_gcd(N, -K);
        auto a = r[0] * (S / d);
        auto b = r[1] * (S / d);
        if (r[2] > 0) {
            auto t = min(a / K, b / N);
            writeln(b - N * t);
        } else {
            auto t = max((a + K - 1) / K, (b + N - 1) / N);
            writeln(N * t - b);
        }
    }
}

/*

S + K * y = N * x
Nx - Ky = S


1 3 1

10x - 3y = 4
10 * 4 - 3 * 12 = 4

10(x-4) - 3(y-12) = 0

x - 4 = 3t
x = 4 + 3t

y - 12 = 10t
y = 12 + 10t


t = -1 => x = 1, y = 2

N(x-a) - K(y-b) = 0

x-a = Kt, x = Kt + a, t = a / K
y-b = Nt, y = Nt + b, t = b / N

10000x - 14y = 6
10000 * -9 - 14 * -6429 = 6

10000(x+9) - 14(y+6429) = 0

x+9 = 14t, x = 14t - 9, t = 9/14 = 1
y+6429 = 10000t, y = 10000t - 6429, t = 6429/10000 = 1

1
85 5 65



*/