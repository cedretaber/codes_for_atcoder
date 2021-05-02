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
    int N, K; get(N, K);
    int[] XX, YY; char[][] CC; get_lines(N, XX, YY, CC);

    auto bb = new int[][](K + 1, K + 1);
    auto ww = new int[][](K + 1, K + 1);
    foreach (i; 0..N) {
        auto x = XX[i] % (K * 2);
        auto y = YY[i] % (K * 2);
        auto c = CC[i][0];

        auto f = (x < K && y < K) || (x >= K && y >= K);
        if ((c == 'B' && f) || (c == 'W' && !f)) {
            ++bb[y % K + 1][x % K + 1];
        } else {
            ++ww[y % K + 1][x % K + 1];
        }
    }
    foreach (y; 1..K + 1) foreach (x; 1..K + 1) {
        bb[y][x] += bb[y - 1][x] + bb[y][x - 1] - bb[y - 1][x - 1];
        ww[y][x] += ww[y - 1][x] + ww[y][x - 1] - ww[y - 1][x - 1]; 
    }
    int r;
    foreach (y; 1..K + 1) foreach (x; 1..K + 1) {
        r = max(
            r,
            bb[K][K] - bb[K][x - 1] - bb[y - 1][K] + bb[y - 1][x - 1] * 2 + ww[K][x - 1] + ww[y - 1][K] - ww[y - 1][x - 1] * 2,
            ww[K][K] - ww[K][x - 1] - ww[y - 1][K] + ww[y - 1][x - 1] * 2 + bb[K][x - 1] + bb[y - 1][K] - bb[y - 1][x - 1] * 2
        );
    }
    writeln(r);
}
