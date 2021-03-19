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
    int W, H; get(W, H);
    int N; get(N);
    int[] xs, ys; get_lines(N, xs, ys);
    auto xx = xs.dup;
    sort(xx);
    xx = [0] ~ xx ~ [W + 1];
    auto yy = ys.dup;
    sort(yy);
    yy = [0] ~ yy ~ [H + 1];
    int[int] xm, ym;
    foreach (i, x; xx) xm[x] = i.to!int;
    foreach (i, y; yy) ym[y] = i.to!int;

    auto DP = new int[][][][](N + 2, N + 2, N + 2, N + 2);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) foreach (ref dp3; dp2) dp3[] = -1;
    int solve(int l, int r, int t, int b) {
        if (DP[l][r][t][b] != -1) return DP[l][r][t][b];

        int res;
        foreach (i; 0..N) if (xx[l] < xs[i] && xs[i] < xx[r] && yy[t] < ys[i] && ys[i] < yy[b]) {
            auto x = xm[xs[i]];
            auto y = ym[ys[i]];
            res = max(res,
                solve(l, x, t, y) +
                solve(l, x, y, b) +
                solve(x, r, t, y) +
                solve(x, r, y, b) +
                xx[r] - xx[l] + yy[b] - yy[t] - 3
            );
        }
        return DP[l][r][t][b] = res;
    }
    writeln(solve(0, N + 1, 0, N + 1));
}
