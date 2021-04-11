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
    int N, M; get(N, M);
    int si, sj, ci, cj, gi, gj;
    auto MAP = new char[][N];
    foreach (i; 0..N) foreach (j, c; readln.chomp) {
        if (c == 'S') {
            si = i;
            sj = j.to!int;
            MAP[i] ~= '.';
        } else if (c == 'C') {
            ci = i;
            cj = j.to!int;
            MAP[i] ~= '.';
        } else if (c == 'G') {
            gi = i;
            gj = j.to!int;
            MAP[i] ~= '.';
        } else {
            MAP[i] ~= c;
        }
    }

    int solve(int si, int sj, int gi, int gj) {
        auto memo = new int[][](N, M);
        foreach (ref m; memo) m[] = int.max / 3;
        memo[si][sj] = 0;
        auto ss = [[si, sj, 0]];
        while (!ss.empty) {
            auto i = ss.front[0];
            auto j = ss.front[1];
            auto t = ss.front[2];
            ss.popFront();
            static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
                auto ii = i + d[0];
                auto jj = j + d[1];
                if (0 <= ii && ii < N && 0 <= jj && jj < M && MAP[ii][jj] != '#' && memo[ii][jj] > t + 1) {
                    memo[ii][jj] = t + 1;
                    ss ~= [ii, jj, t + 1];
                }
            }}
        }
        return memo[gi][gj];
    }

    auto res = solve(si, sj, ci, cj) + solve(ci, cj, gi, gj);
    writeln(res >= int.max / 3 ? -1 : res);
}
