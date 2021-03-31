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
    auto ss = new int[][](N, N);
    foreach (i; 0..(N + 1) / 2) foreach (j; i..N - i) foreach (k; i..N - i) ss[j][k] = i;
    auto es = new bool[][](N, N);

    int[] PS; get(PS);
    int r;
    foreach (p; PS) {
        p -= 1;
        auto y = p / N;
        auto x = p % N;
        es[y][x] = true;
        r += ss[y][x];

        if (ss[y][x] == 0) {
            ss[y][x] = -1;
        } else {
            static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
                auto xx = x + d[0];
                auto yy = y + d[1];
                if (0 <= xx && xx < N && 0 <= yy && yy < N) ss[y][x] = min(ss[y][x], ss[yy][xx]);
            }}
        }

        void solve(int x, int y) {
            auto c = ss[y][x] + 1;
            static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
                auto xx = x + d[0];
                auto yy = y + d[1];
                if (0 <= xx && xx < N && 0 <= yy && yy < N) {
                    if (ss[y][x] == -1 && es[yy][xx] && ss[yy][xx] != -1) {
                        ss[yy][xx] = -1;
                        solve(xx, yy);
                    } else if (ss[yy][xx] > c || (es[yy][xx] && ss[yy][xx] > c - 1)) {
                        ss[yy][xx] = c;
                        if (es[yy][xx]) --ss[yy][xx];
                        solve(xx, yy);
                    }
                }
            }}
        }
        solve(x, y);
    }
    writeln(r);
}
