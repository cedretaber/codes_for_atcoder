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
    int N; get(N);
    int X, Y; get(X, Y);

    auto DP = new int[][](301, 301);
    foreach (ref dp; DP) dp[] = int.max / 3;
    DP[0][0] = 0;

    while (N--) {
        int A, B; get(A, B);
        foreach_reverse (i; 0..301) foreach_reverse (j; 0..301) if (DP[i][j] != int.max / 3) {
            auto ii = min(300, i + A);
            auto jj = min(300, j + B);
            DP[ii][jj] = min(DP[ii][jj], DP[i][j] + 1);
        }
    }
    auto r = int.max / 3;
    foreach (i; X..301) foreach (j; Y..301) r = min(r, DP[i][j]);
    writeln(r == int.max / 3 ? -1 : r);
}
