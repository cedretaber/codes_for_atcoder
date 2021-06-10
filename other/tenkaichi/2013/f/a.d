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

enum P = 10^^9 + 7;

void main()
{
    int N, M; get(N, M);

    auto DP = new int[][](N * M + 1, 2^^(M + 1));
    DP[0][0] = 1;
    auto MASK = (1 << (M + 1)) - 1;
    foreach (i; 0..N) foreach (j; 0..M) foreach (k; 0..2^^(M + 1)) if (DP[i * M + j][k]) {
        auto f = (k << 1) & MASK;
        auto p = DP[i * M + j][k];
        (DP[i * M + j + 1][f] += p) %= P;
        if (M == 1) {
            if (!(k & 1)) (DP[i * M + j + 1][f + 1] += p) %= P;
        } else if (M == 2) {
            if (j == 0 && !(k & 3)) (DP[i * M + j + 1][f + 1] += p) %= P;
            if (j == 1 && !(k & 7)) (DP[i * M + j + 1][f + 1] += p) %= P;
        } else {
            if (j == 0 && !(k & (1 << (M - 1))) && !(k & (1 << (M - 2)))) (DP[i * M + j + 1][f + 1] += p) %= P;
            if (j == M - 1 && !(k & 1) && !(k & (1 << M)) && !(k & (1 << (M - 1)))) (DP[i * M + j + 1][f + 1] += p) %= P;
            if (0 < j && j < M - 1 && !(k & 1) && !(k & (1 << M)) && !(k & (1 << (M - 1))) && !(k & (1 << (M - 2)))) (DP[i * M + j + 1][f + 1] += p) %= P;
        }
    }
    int r;
    foreach (k; 0..2^^(M + 1)) (r += DP[N * M][k]) %= P;
    writeln(r - 1);
}
