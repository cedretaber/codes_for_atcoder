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
    int N; long W; get(N, W);
    long[] VV, WW; VV.reserve(N); WW.reserve(N);
    long max_v, max_w;
    foreach (_; 0..N) {
        long v, w; get(v, w);
        VV ~= v;
        WW ~= w;
        max_v = max(max_v, v);
        max_w = max(max_w, w);
    }

    if (max_v <= 1000) {
        auto MAX = N * 1000 + 1;
        auto DP = new long[][](2, MAX);
        DP[0][] = long.max / 3; DP[0][0] = 0;
        foreach (i; 0..N) {
            auto ii = i % 2;
            auto jj = (i + 1) % 2;
            DP[jj][] = DP[ii][];
            foreach (v; 0..MAX) if (v + VV[i] < MAX && DP[jj][v + VV[i]] > DP[ii][v] + WW[i]) DP[jj][v + VV[i]] = DP[ii][v] + WW[i];
        }
        max_v = 0;
        foreach_reverse (v, w; DP[N % 2]) if (w <= W) max_v = max(v, max_v);
        writeln(max_v);
    } else if (max_w <= 1000) {
        auto MAX = N * 1000 + 1;
        auto DP = new long[][](2, W + 1);
        foreach (i; 0..N) {
            auto ii = i % 2;
            auto jj = (i + 1) % 2;
            DP[jj][] = DP[ii][];
            foreach (w; 0..W + 1) if (w + WW[i] < W + 1 && DP[jj][w + WW[i]] < DP[ii][w] + VV[i]) DP[jj][w + WW[i]] = DP[ii][w] + VV[i];
        }
        writeln(DP[N % 2].maxElement());
    } else {
        alias VW = Tuple!(long, "v", long, "w");
        void run(int i, long v, long w, long[] vv, long[] ww, ref VW[] vw) {
            if (i == vv.length) {
                vw ~= VW(v, w);
            } else {
                run(i + 1, v, w, vv, ww, vw);
                run(i + 1, v + vv[i], w + ww[i], vv, ww, vw);
            }
        }
        VW[] xx;
        run(0, 0, 0, VV[0..min($, 15)], WW[0..min($, 15)], xx);
        if (N <= 15) return writeln(xx.filter!(x => x.w <= W).map!"a.v"().maxElement());
        VW[] yy;
        run(0, 0, 0, VV[15..$], WW[15..$], yy);
        sort!"a.w < b.w"(yy);
        foreach (i, ref y; yy) if (i > 0) y.v = max(yy[i - 1].v, y.v);

        long res;
        foreach (x; xx) {
            if (x.w > W) continue;
            res = max(res, x.v);

            if (x.w + yy[0].w > W) continue;
            int l, r = yy.length.to!int;
            while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (x.w + yy[m].w <= W) {
                    l = m;
                } else {
                    r = m;
                }
            }
            res = max(res, x.v + yy[l].v);
        }
        writeln(res);
    }
}
