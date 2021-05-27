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
    char[][] BB; get_lines(H, BB);

    auto memo = new bool[][](H, W);
    foreach (i; 0..H) foreach (j; 0..W) {
        auto c = BB[i][j];
        if (i + 2 < H && BB[i + 1][j] == c && BB[i + 2][j] == c) {
            memo[i][j] = memo[i + 1][j] = memo[i + 2][j] = true;
        }
        if (j + 2 < W && BB[i][j + 1] == c && BB[i][j + 2] == c) {
            memo[i][j] = memo[i][j + 1] = memo[i][j + 2] = true;
        }
    }

    int r;
    foreach (i; 0..H) foreach (j; 0..W) if (memo[i][j]) {
        ++r;
        auto c = BB[i][j];
        memo[i][j] = false;
        void put(int i, int j) {
            static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
                auto ii = i + d[0];
                auto jj = j + d[1];
                if (0 <= ii && ii < H && 0 <= jj && jj < W && BB[ii][jj] == c && memo[ii][jj]) {
                    memo[ii][jj] = false;
                    put(ii, jj);
                }
            }}
        }
        put(i, j);
    }
    writeln(r);
}
