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
    int N, D; get(N, D);
    int X, Y; get(X, Y); X = abs(X); Y = abs(Y);
    if (X % D != 0 || Y % D != 0) return writeln(0);

    auto x = X / D;
    auto y = Y / D;
    if (x > 100 || y > 100) return writeln(0);

    auto memo = new double[][](101, 101);
    foreach (ref l; memo) l[] = 0;
    memo[0][0] = 1;

    while (N--) {
        auto memo2 = new double[][](101, 101);
        foreach (ref l; memo2) l[] = 0;
        foreach (i; 0..101) foreach (j; 0..101) {
            static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
                auto ii = i + d[0];
                auto jj = j + d[1];
                if (0 <= ii && ii <= 100 && 0 <= jj && jj <= 100) {
                    memo2[ii][jj] += memo[i][j] / 4;
                }
            }}
        }
        foreach (i; 0..101) {
            memo2[i][0] += memo[i][1] / 4;
            memo2[0][i] += memo[1][i] / 4;
        }
        memo = memo2;
    }
    writefln!"%.12f"(memo[y][x]);
}
