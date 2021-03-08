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
    int H, W, K; get(H, W, K);
    char[][] MAP; get_lines(H, MAP);
    int si, sj;
    outer: foreach (i, line; MAP) foreach (j, c; line) if (c == 'S') {
        si = i.to!int;
        sj = j.to!int;
        break outer;
    }

    int r = int.max;
    auto memo = new bool[][](H, W);
    memo[si][sj] = true;
    auto ss = [[si, sj, K]];
    while (!ss.empty) {
        auto i = ss.front[0];
        auto j = ss.front[1];
        auto k = ss.front[2];
        ss.popFront();

        r = min(r, (min(i, H - i - 1, j, W - j - 1) + K - 1) / K);
        if (k) static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
            auto ii = i + d[0];
            auto jj = j + d[1];
            if (0 <= ii && ii < H && 0 <= jj && jj < W && MAP[ii][jj] != '#' && !memo[ii][jj]) {
                memo[ii][jj] = true;
                ss ~= [ii, jj, k - 1];
            }
        }}
    }
    writeln(r + 1);
}
