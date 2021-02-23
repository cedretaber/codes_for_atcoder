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
    int[][] aa; get_lines(H, aa);
    auto MIN_A = int.max;
    foreach (i; 0..H) foreach (j; 0..W) MIN_A = min(MIN_A, aa[i][j]);

    int solve() {
        auto max_up = new int[][](H, W);
        auto max_down = new int[][](H, W);
        auto min_down = new int[][](H, W);
        foreach (j; 0..W) {
            int max_a, min_a = 10^^9+1;
            foreach (i; 0..H) {
                max_a = max(max_a, aa[i][j]);
                max_up[i][j] = max_a;
            }
            max_a = 0;
            foreach_reverse (i; 0..H) {
                max_a = max(max_a, aa[i][j]);
                min_a = min(min_a, aa[i][j]);
                max_down[i][j] = max_a;
                min_down[i][j] = min_a;
            }
        }

        bool search(int D) {
            auto max_a = MIN_A + D;
            if (aa[0][0] > max_a) return false;

            int p = H-1;
            int u_max, u_min = 10^^9;
            foreach (w; 0..W) {
                if (p == -1 || aa[0][w] > max_a) {
                    u_max = max(u_max, max_down[0][w]);
                    u_min = min(u_min, min_down[0][w]);
                    p = -1;
                } else {
                    int l, r = w == W-1 ? H-1 : H;
                    while (l + 1 < r) {
                        auto m = (l + r) / 2;
                        if (max_up[m][w] <= max_a) {
                            l = m;
                        } else {
                            r = m;
                        }
                    }
                    p = min(p, l);
                    r = p + 1;
                    if (r < H) {
                        u_max = max(u_max, max_down[r][w]);
                        u_min = min(u_min, min_down[r][w]);
                    }
                }
            }

            return u_max - u_min <= D;
        }

        int l, r = 10^^9;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            if (search(m)) {
                r = m;
            } else {
                l = m;
            }
        }
        return r;
    }

    auto r = solve();
    aa.reverse();
    r = min(r, solve());
    foreach (ref a; aa) a.reverse();
    r = min(r, solve());
    aa.reverse();
    writeln(min(r, solve()));
}