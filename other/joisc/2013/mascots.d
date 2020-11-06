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
    int R, C; get(R, C);
    int N; get(N);

    auto F = new long[](R * C + 1);
    F[0] = F[1] = 1;
    foreach (long i; 2..R*C+1) (F[i] = F[i-1] * i) %= P;

    long min_x = C, max_x, min_y = R, max_y;
    foreach (_; 0..N) {
        long A, B; get(A, B);
        min_x = min(min_x, B);
        max_x = max(max_x, B);
        min_y = min(min_y, A);
        max_y = max(max_y, A);
    }

    auto res = F[(max_x - min_x + 1) * (max_y - min_y + 1) - N];

    auto DP = new long[][](R+1, C+1);
    DP[R][C] = 1;
    foreach_reverse (i; 1..R+1) foreach_reverse (j; 1..C+1) if (i != R || j != C) {
        long r;
        if (i < R) (r += DP[i+1][j] * F[j]) %= P;
        if (j < C) (r += DP[i][j+1] * F[i]) %= P;
        DP[i][j] = r;
    }
    (res *= DP[max_y - min_y + 1][max_x - min_x + 1]) %= P;

    long t = min_y - 1, d = R - max_y, l = min_x - 1, r = C - max_x;
    (res *= F[t + d] * inv(F[t]) % P * inv(F[d]) % P) %= P;
    (res *= F[l + r] * inv(F[l]) % P * inv(F[r]) % P) %= P;

    writeln(res);
}