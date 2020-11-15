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

enum P = 10L^^9 + 7;

void main()
{
    int H, W; get(H, W);
    char[][] SS;
    foreach (_; 0..H) SS ~= readln.chomp.to!(char[]);

    auto rs = new long[][](H+1, W+1);
    auto as = new long[][](H+1, W+1);
    auto bs = new long[][](H+1, W+1);
    auto cs = new long[][](H+1, W+1);
    rs[0][0] = 1;
    foreach (i; 0..H) foreach (j; 0..W) if (SS[i][j] == '.') {
        (rs[i][j] += as[i][j] + bs[i][j] + cs[i][j]) %= P;
        (as[i+1][j] += as[i][j] + rs[i][j]) %= P;
        (bs[i][j+1] += bs[i][j] + rs[i][j]) %= P;
        (cs[i+1][j+1] += cs[i][j] + rs[i][j]) %= P;
    }
    writeln(rs[H-1][W-1]);
}

/*

3 3
112
1#3
2310

11.
.#.
...


112#
12..
23#.
36..

*/