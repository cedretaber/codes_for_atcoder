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
    int H, W; long C; get(H, W, C);
    long[][] AA; get_lines(H, AA);

    long solve() {
        auto DP = new long[][](H, W);
        foreach (ref dp; DP) dp[] = long.max / 3;
        foreach (i; 0..H) foreach (j; 0..W) {
            if (i > 0) DP[i][j] = min(DP[i][j], DP[i - 1][j] + C, AA[i - 1][j] + C);
            if (j > 0) DP[i][j] = min(DP[i][j], DP[i][j - 1] + C, AA[i][j - 1] + C);
        }
        auto res = long.max;
        foreach (i; 0..H) foreach (j; 0..W) res = min(res, AA[i][j] + DP[i][j]);
        return res;
    }

    auto res = solve();
    foreach (i; 0..H) foreach (j; 0..W / 2) swap(AA[i][j], AA[i][W - j - 1]);
    writeln(min(res, solve()));
}
