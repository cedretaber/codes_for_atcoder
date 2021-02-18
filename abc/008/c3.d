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
    int[] CS; get_lines(N, CS);
    auto cs = new int[](N);
    foreach (i; 0..N) foreach (j; 0..N) if (i != j && CS[i] % CS[j] == 0) ++cs[i];

    auto ps = new double[][](N + 1, N + 1);
    foreach (ref p; ps) p[] = 0;
    ps[0][0] = 1;
    foreach (i; 0..N) foreach (j; 0..i + 1) {
        ps[i+1][j] += ps[i][j];
        ps[i+1][j+1] += ps[i][j];
    }

    double r = 0;
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            double x = 0;
            int c = 0;
            while (c <= min(cs[i], j)) {
                x += ps[cs[i]][c] * ps[N - cs[i] - 1][j - c];
                c += 2;
            }
            r += x / ps[N-1][j] / N;
        }
    }
    writefln!"%.12f"(r);
}