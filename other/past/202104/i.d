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

void main()
{
    int H, W; get(H, W);
    long[][] AA; get_lines(H, AA);

    auto DP = new long[][][](H, W, H + W);
    foreach (i; 0..H) foreach (j; 0..W) foreach (k; 0..H + W) {
        if (i + 1 < H) {
            DP[i + 1][j][k] = max(DP[i + 1][j][k], DP[i][j][k]);
            if (k < H + W - 1) DP[i + 1][j][k + 1] = max(DP[i + 1][j][k + 1], DP[i][j][k] + AA[i][j]);
        }
        if (j + 1 < W) {
            DP[i][j + 1][k] = max(DP[i][j + 1][k], DP[i][j][k]);
            if (k < H + W - 1) DP[i][j + 1][k + 1] = max(DP[i][j + 1][k + 1], DP[i][j][k] + AA[i][j]);
        }
    }
    foreach_reverse (k; 0..H + W - 1) {
        DP[H - 1][W - 1][k + 1] = max(DP[H - 1][W - 1][k + 1], DP[H - 1][W - 1][k] + AA[H - 1][W - 1]);
    }

    foreach (i; 1..H + W) writeln(DP[H - 1][W - 1][i]);
}
