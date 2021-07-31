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
    int[][] AA, BB; get_lines(H, AA); get_lines(H, BB);
    auto cc = new int[][](H, W);
    foreach (i; 0..H) foreach (j; 0..W) cc[i][j] = abs(AA[i][j] - BB[i][j]);

    auto DP = new bool[][][](H, W, 6401);
    DP[0][0][cc[0][0]] = true;
    foreach (i; 0..H) foreach (j; 0..W) foreach (k; 0..6401) {
        if ((i > 0 && DP[i - 1][j][k]) || (j > 0 && DP[i][j - 1][k])) {
            DP[i][j][abs(k - cc[i][j])] = true;
            if (k + cc[i][j] <= 6400) DP[i][j][k + cc[i][j]] = true;
        }
    }
    foreach (i; 0..6401) if (DP[H - 1][W - 1][i]) return writeln(i);
}
