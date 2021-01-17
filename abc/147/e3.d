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
    int[][] AS, BS; get_lines(H, AS); get_lines(H, BS);

    enum MAX = 80 * 80 + 1;
    auto DP = new bool[][][](H + 1, W + 1, MAX);
    DP[0][0][0] = true;
    foreach (i; 0..H) foreach (j; 0..W) {
        auto c = abs(AS[i][j] - BS[i][j]);
        foreach (k; 0..MAX) if (DP[i][j][k]) {
            static foreach (d; [[0, 1], [1, 0]]) {{
                auto ii = i + d[0];
                auto jj = j + d[1];
                if (k + c < MAX) DP[ii][jj][k + c] = true;
                DP[ii][jj][abs(k - c)] = true;
            }}
        }
    }
    auto r = int.max;
    foreach (k; 0..MAX) if (DP[H-1][W-1][k]) {
        r = min(r, abs(k + AS[H-1][W-1] - BS[H-1][W-1]));
        r = min(r, abs(k - AS[H-1][W-1] + BS[H-1][W-1]));
    }
    writeln(r);
}