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

long P = 10^^9+7;
long[10^^5+50] F, RF;

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

long modinv(long a, long m)
{
    long b = m, u = 1, v = 0;
    while (b) {
        auto t = a / b;
        a -= t * b; swap(a, b);
        u -= t * v; swap(u, v);
    }
    u %= m;
    if (u < 0) u += m;
    return u;
}

void init()
{
    F[0] = F[1] = 1;
    foreach (i, ref x; F[2..$]) x = (F[i+1] * (i+2)) % P;

    {
        RF[$-1] = 1;
        auto x = F[$-1];
        auto k = P-2;
        while (k) {
            if (k%2 == 1) RF[$-1] = (RF[$-1] * x) % P;
            x = x^^2 % P;
            k /= 2;
        }
    }
    foreach_reverse(i, ref x; RF[0..$-1]) x = (RF[i+1] * (i+1)) % P;
}

long comb(N)(N n, N k)
{
    if (k > n) return 0;
    auto n_b = F[n];    // n!
    auto nk_b = RF[n-k]; // 1 / (n-k)!
    auto k_b = RF[k];    // 1 / k!

    auto nk_b_k_b = (nk_b * k_b) % P; // 1 / (n-k)!k!

    return (n_b * nk_b_k_b) % P;  // n! / (n-k)!k!
}

Tuple!(N, N)[] prime_division(N)(N n)
{
    auto nn = n;
    Tuple!(N, N)[] res;
    for (N i = 2; i^^2 <= nn; ++i) {
        if (n%i == 0) {
            N cnt;
            while (n%i == 0) {
                ++cnt;
                n /= i;
            }
            res ~= tuple(i, cnt);
        }
    }
    if (n != cast(N)1) res ~= tuple(n, cast(N)1);
    return res;
}

void main()
{
    init();
    long N, M; get(N, M);
    long r = 1;
    foreach (pc; prime_division(M)) {
        auto c = pc[1];
        (r *= comb(N + c - 1, N - 1)) %= P;
    }
    writeln(r);
}