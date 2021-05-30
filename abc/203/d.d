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
    int[][] AA; get_lines(N, AA);

    auto cs = new int[][](N + 1, N + 1);
    int l = -1, r = 10^^9;
    while (l + 1 < r) {
        auto m = (l + r) / 2;
        foreach (i; 0..N) foreach (j; 0..N) cs[i + 1][j + 1] = AA[i][j] <= m ? 1 : 0;
        foreach (i; 0..N) foreach (j; 0..N) cs[i + 1][j + 1] += cs[i + 1][j] + cs[i][j + 1] - cs[i][j];
        bool ok;
        outer: foreach (i; 0..N - K + 1) foreach (j; 0..N - K + 1) {
            auto k = cs[i + K][j + K] - cs[i + K][j] - cs[i][j + K] + cs[i][j];
            if (k >= (K^^2 + 1) / 2) {
                ok = true;
                break outer;
            }
        }
        if (ok) {
            r = m;
        } else {
            l = m;
        }
    }
    writeln(r);
}
