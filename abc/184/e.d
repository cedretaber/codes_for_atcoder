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
    auto MAP = new char[][](H, W);
    int[]['z' + 1] ts;
    int sx, sy, gx, gy;
    foreach (i; 0..H) {
        foreach (jj, c; readln.chomp) {
            auto j = jj.to!int;
            MAP[i][j] = c;
            if (c == 'S') {
                sx = j;
                sy = i;
            } else if (c == 'G') {
                gx = j;
                gy = i;
            } else if ('a' <= c && c <= 'z') {
                auto x = i * W + j;
                ts[c] ~= x;
            }
        }
    }

    auto DP = new int[][](H, W);
    foreach (ref dp; DP) dp[] = int.max/3;
    DP[sy][sx] = 0;
    auto ss = [[sy, sx]];
    while (!ss.empty) {
        auto i = ss.front[0];
        auto j = ss.front[1];
        ss.popFront();
        static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
            auto ii = i+d[0];
            auto jj = j+d[1];
            if (0 <= ii && ii < H && 0 <= jj && jj < W && MAP[ii][jj] != '#' && DP[ii][jj] > DP[i][j] + 1) {
                ss ~= [ii, jj];
                DP[ii][jj] = DP[i][j] + 1;
            }
        }}
        auto c = MAP[i][j];
        if ('a' <= c && c <= 'z') {
            foreach (x; ts[c]) {
                auto ii = x / W;
                auto jj = x % W;
                if (DP[ii][jj] > DP[i][j] + 1) {
                    ss ~= [ii, jj];
                    DP[ii][jj] = DP[i][j] + 1;
                }
            }
            ts[c] = [];
        }
    }

    writeln(DP[gy][gx] == int.max/3 ? -1 : DP[gy][gx]);
}