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
    char[][] MAP; get_lines(H, MAP);
    
    auto DP = new int[][](H, W);
    foreach_reverse (i; 0..H) foreach_reverse (j; 0..W) {
        if (i == H - 1 && j == W - 1) {
            DP[i][j] = 0;
            continue;
        }
        auto r1 = int.min / 3;
        auto r2 = int.min / 3;
        if (i + 1 < H) {
            r1 = (MAP[i + 1][j] == '+' ? 1 : -1) - DP[i + 1][j];
        }
        if (j + 1 < W) {
            r2 = (MAP[i][j + 1] == '+' ? 1 : -1) - DP[i][j + 1];
        }
        DP[i][j] = max(r1, r2);
    }
    writeln(DP[0][0] == 0 ? "Draw" : DP[0][0] > 0 ? "Takahashi" : "Aoki");
}
