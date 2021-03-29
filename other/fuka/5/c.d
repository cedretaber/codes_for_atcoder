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
    for (;;) {
        int W, H, P; get(W, H, P);
        if (!W && !H && !P) return;

        int[][] Z; get_lines(H, Z);

        auto memo = new int[][](H, W);
        void pour(int x, int y) {
            static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
                auto xx = x + d[0];
                auto yy = y + d[1];
                if (0 <= xx && xx < W && 0 <= yy && yy < H && !memo[yy][xx] && Z[yy][xx] < Z[y][x]) {
                    memo[yy][xx] = 1;
                    pour(xx, yy);
                }
            }}
        }
        while (P--) {
            int x, y; get(x, y);
            memo[y][x] = 1;
            pour(x, y);
        }
        writeln(memo.joiner().sum());
    }
}
