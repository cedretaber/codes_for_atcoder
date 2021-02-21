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

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

long[] min_ks(long N, long K)
{
    auto res = new long[](K + 1);
    foreach (i; 1..K+1) res[i] = pow(K - i + 1, N);
    foreach_reverse (i; 1..K) res[i] -= res[i+1];
    return res;
}

long[] max_ks(long N, long K)
{
    auto res = new long[](K + 1);
    foreach (i; 1..K+1) res[i] = pow(i, N);
    foreach (i; 1..K+1) res[i] -= res[i-1];
    return res;
}

void main()
{
    long N, M, K; get(N, M, K);

    if (K == 1) {
        writeln(1);
    } else if (N == 1 && M == 1) {
        writeln(K);
    } else if (N == 1) {
        writeln(pow(K, M));
    } else if (M == 1) {
        writeln(pow(K, N));
    } else {
        auto aa = new long[](K + 1);
        auto bb = new long[](K + 1);
        foreach (i; 1..K+1) {
            aa[i] = pow(i, M);
            bb[i] = pow(K - i + 1, N);
        }
        foreach_reverse (i; 1..K+1) (aa[i] += P - aa[i-1]) %= P;

        long r;
        foreach (a; 1..K+1) {
            (r += aa[a] * bb[a] % P) %= P;
        }
        writeln(r);
    }
}

/*

A=1 (1,1) (1,2) (2,1) (1,3) (3,1)
A=2 (2,2) (2,3) (3,2)
A=3 (3,3)

B=1 (1,1)
B=2 (2,2) (2,1) (1,2)
B=3 (3,1) (1,3) (2,3) (3,1) (3,3)

*/