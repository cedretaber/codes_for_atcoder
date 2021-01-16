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

void main()
{
    int H, W, K; get(H, W, K);
    auto F = new char[][](H, W);
    foreach (_; 0..K) {
        int h, w; char[] cs; get(h, w, cs); --h; --w;
        F[h][w] = cs[0];
    }
    auto DP = new long[][](H + 1, W + 1);
    DP[0][0] = 1;
    foreach (_; 0..H*W-K) (DP[0][0] *= 3) %= P;

    auto inv = modinv(3, P);

    foreach (i; 0..H) foreach (j; 0..W) {
        switch (F[i][j]) {
            case 'R':
                (DP[i][j+1] += DP[i][j]) %= P;
                break;
            case 'D':
                (DP[i+1][j] += DP[i][j]) %= P;
                break;
            case 'X':
                (DP[i][j+1] += DP[i][j]) %= P;
                (DP[i+1][j] += DP[i][j]) %= P;
                break;
            default:
                (DP[i][j+1] += DP[i][j] * 2 % P * inv) %= P;
                (DP[i+1][j] += DP[i][j] * 2 % P * inv) %= P;
        }
    }
    writeln(DP[H-1][W-1]);
}