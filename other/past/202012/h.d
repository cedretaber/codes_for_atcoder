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

enum D = [[0,1], [1,0], [0,-1], [-1,0]];

void main()
{
    int H, W; get(H, W);
    int r, c; get(r, c); --r; --c;
    char[][] MAP; get_lines(H, MAP);

    auto res = new bool[][](H, W);
    auto ss = [[r, c]];
    res[r][c] = true;
    while (!ss.empty) {
        auto i = ss.front[0];
        auto j = ss.front[1];
        ss.popFront();
        static foreach (d; 0..4) {{
            auto ii = i + D[d][0];
            auto jj = j + D[d][1];
            if (
                0 <= ii && ii < H && 0 <= jj && jj < W && MAP[ii][jj] != '#' && !res[ii][jj] && (
                    MAP[ii][jj] == '.' ||
                    (MAP[ii][jj] == '<' && d == 0) ||
                    (MAP[ii][jj] == '^' && d == 1) ||
                    (MAP[ii][jj] == '>' && d == 2) ||
                    (MAP[ii][jj] == 'v' && d == 3)
                )
            ) {
                res[ii][jj] = true;
                ss ~= [ii, jj];
            }
        }}
    }
    foreach (i; 0..H) foreach (j; 0..W) if (MAP[i][j] != '#') MAP[i][j] = res[i][j] ? 'o' : 'x';
    writefln!"%-(%s\n%)"(MAP);
}