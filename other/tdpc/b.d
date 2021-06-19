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
    int A, B; get(A, B);
    int[] AA, BB; get(AA); get(BB);
    auto DP = new int[][][](A + 1, B + 1, 2);
    foreach (i; 0..A + 1) foreach (j; 0..B + 1) {
        auto k = (i + j) % 2;
        int a, b;
        if (i > 0) {
            auto c = DP[i - 1][j][k] + AA[A - i];
            if (c > a) {
                a = c;
                b = DP[i - 1][j][(k + 1) % 2];
            }
        }
        if (j > 0) {
            auto c = DP[i][j - 1][k] + BB[B - j];
            if (c > a) {
                a = c;
                b = DP[i][j - 1][(k + 1) % 2];
            }
        }
        DP[i][j][k] = a;
        DP[i][j][(k + 1) % 2] = b;
    }
    writeln(DP[A][B][(A + B) % 2]);
}
