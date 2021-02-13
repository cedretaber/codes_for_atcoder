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
    char[][] ss; get_lines(H, ss);

    auto ii = new int[][H];
    auto jj = new int[][W];
    int[] yy, xx;
    int c;
    foreach (i; 0..H) foreach (j; 0..W) if (ss[i][j] == '#') {
        ii[i] ~= c;
        jj[j] ~= c;
        ++c;
        yy ~= i;
        xx ~= j;
    }

    int solve(int H, int W, int[][] ii, int[][] jj, int[] yy, int[] xx) {
        auto hs = new int[](H);
        hs[] = -1;
        hs[0] = hs[H-1] = 0;
        auto memo = new bool[](W);
        int[] jx;
        foreach (k; chain(ii[0], ii[H-1])) {
            auto j = xx[k];
            if (memo[j]) continue;
            memo[j] = true;
            jx ~= j;
        }
        foreach (k; chain(jj[0], jj[W-1])) {
            auto i = yy[k];
            if (hs[i] != -1) continue;
            hs[i] = 0;
            foreach (l; ii[i]) {
                auto j = xx[l];
                if (memo[j]) continue;
                memo[j] = true;
                jx ~= j;
            }
        }
        int c = 0;
        foreach (hi; 0..H) {
            if (hs[hi] == -1) {
                hs[hi] = ++c;
                foreach (k; ii[hi]) {
                    auto j = xx[k];
                    if (memo[j]) continue;
                    memo[j] = true;
                    jx ~= j;
                }
            }
            while (!jx.empty) {
                auto j = jx.front;
                jx.popFront();
                foreach (k; jj[j]) {
                    auto i = yy[k];
                    if (hs[i] != -1) continue;
                    hs[i] = c;
                    foreach (l; ii[i]) {
                        auto j2 = xx[l];
                        if (memo[j2]) continue;
                        memo[j2] = true;
                        jx ~= j2;
                    }
                }
            }
        }
        return c;
    }

    writeln(min(solve(H, W, ii, jj, yy, xx), solve(W, H, jj, ii, xx, yy)));
}