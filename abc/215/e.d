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

void main()
{
    int N; get(N);
    char[] S; get(S);

    auto DP = new long[][][](11, 2 ^^ 10, N + 1);
    DP[0][0][0] = 1;
    foreach (i; 0..N) foreach (j; 0..2 ^^ 10) foreach (k; 0..11) {
        (DP[k][j][i + 1] += DP[k][j][i]) %= P;

        auto c = S[i] - 'A';
        if (k == c + 1) {
            (DP[k][j][i + 1] += DP[k][j][i]) %= P;
        } else if (!(j & (1 << c))) {
            auto jj = k == 0 ? j : (j | (1 << (k - 1)));
            (DP[c + 1][jj][i + 1] += DP[k][j][i]) %= P;
        }
    }
    long r;
    foreach (j; 0..2 ^^ 10) foreach (k; 0..11) (r += DP[k][j][N]) %= P;
    writeln((r + P - 1) % P);
}