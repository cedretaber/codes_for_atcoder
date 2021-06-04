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
    int N, A, B; get(N, A, B);
    double[] VS; get(VS);

    auto cs = new long[][](N + 1, N + 1);
    cs[0][0] = 1;
    foreach (i; 0..N) foreach (j; 0..i + 1) {
        cs[i + 1][j] += cs[i][j];
        cs[i + 1][j + 1] += cs[i][j];
    }

    VS.sort!"a > b";
    writefln!"%.12f"(VS[0..A].sum / A);
    auto c = VS.count!(v => v == VS[A - 1]);
    long res;
    if (VS[0] == VS[A - 1]) {
        foreach (x; A..B + 1) {
            if (x > c) break;
            res += cs[c][x];
        }
    } else {
        auto d = VS[0..A].count!(v => v == VS[A - 1]);
        res = cs[c][d];
    }
    writeln(res);
}
