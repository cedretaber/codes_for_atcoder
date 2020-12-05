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

enum P = 10L^^9+7;

void main()
{
    int N, K; get(N, K);
    char[] S; get(S);

    auto DP = new long[][][](2, K+1, K+1);
    DP[0][0][0] = 1;
    foreach (i; 0..N) {
        auto i1 = i % 2;
        auto i2 = (i + 1) % 2;
        foreach (ref dp; DP[i2]) dp[] = 0;
        switch (S[i]) {
            case '1':
                foreach (j; 0..K) foreach (k; 0..K+1) (DP[i2][j+1][max(0, k - 1)] += DP[i1][j][k]) %= P;
                break;
            case '0':
                foreach (j; 0..K+1) foreach (k; 0..K) (DP[i2][max(0, j - 1)][k+1] += DP[i1][j][k]) %= P;
                break;
            default:
                foreach (j; 0..K) foreach (k; 0..K+1) (DP[i2][j+1][max(0, k - 1)] += DP[i1][j][k]) %= P;
                foreach (j; 0..K+1) foreach (k; 0..K) (DP[i2][max(0, j - 1)][k+1] += DP[i1][j][k]) %= P;
        }
    }

    long r;
    foreach (i; 0..K+1) foreach (j; 0..K+1) (r += DP[N % 2][i][j]) %= P;
    writeln(r);
}