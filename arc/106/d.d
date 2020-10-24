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

long inv(long x)
{
    return pow(x, P-2);
}

void main()
{
    int N, K; get(N, K);
    long[] AS; get(AS);

    auto FS = new long[](K+1);
    FS[0] = FS[1] = 1;
    foreach (i; 2..K+1) FS[i] = FS[i-1] * i % P;
    auto memo = new long[](K+1);
    foreach (k; 0..K+1) {
        foreach (i; 0..N) {
            (memo[k] += pow(AS[i], k)) %= P;
        }
    }

    foreach (x; 1..K+1) {
        long n, r;
        foreach (k; 0..x+1) {
            (n += memo[k] * memo[x-k] % P * inv(FS[k]) % P * inv(FS[x-k]) % P) %= P;
        }
        foreach (i; 0..N) {
            (r += pow(AS[i] * 2 % P, x)) %= P;
        }
        n = (n * FS[x] % P - r + P) % P * inv(2) % P;
        writeln(n);
    }
}

/*

X! * S{k=0->x}( (1/k!) * (1/(X-k)) * S{i=1->N}(A_i^k) * S{j=1->N}(A_j^(X-k)) )
- S{i=1->N}((A_i * 2)^k) / 2

*/