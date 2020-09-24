import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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
    int N, W; get(N, W);
    long[] vs, ws; get_lines(N, vs, ws);

    if (ws.maxElement <= 1000) {
        W = min(W, N*1000);
        auto DP = new long[][](N+1, W+1);
        foreach (i; 0..N) {
            foreach (j; 0..W+1) {
                DP[i+1][j] = max(DP[i+1][j], DP[i][j]);
                if (j + ws[i] <= W) DP[i+1][j+ws[i]] = max(DP[i+1][j+ws[i]], DP[i][j] + vs[i]);
            }
        }
        writeln(DP[N][].maxElement);
    } else if (vs.maxElement <= 1000) {
        auto DP = new long[][](N+1, 1000*N+1);
        foreach (ref dp; DP) dp[] = long.max/3;
        DP[0][0] = 0;
        foreach (i; 0..N) {
            foreach (j; 0..1000*N+1) {
                DP[i+1][j] = min(DP[i+1][j], DP[i][j]);
                if (j+vs[i] <= 1000*N) DP[i+1][j+vs[i]] = min(DP[i+1][j+vs[i]], DP[i][j] + ws[i]);
            }
        }
        foreach_reverse (i, w; DP[N]) if (w <= W) {
            writeln(i);
            return;
        }
    } else {
        alias R = Tuple!(long, "v", long, "w");
        void run(int i, int j, long v, long w, ref R[] rs) {
            if (i == j) {
                rs ~= R(v, w);
            } else {
                run(i+1, j, v, w, rs);
                run(i+1, j, v + vs[i], w + ws[i], rs);
            }
        }
        R[] rs1, rs2;
        run(0, N/2, 0, 0, rs1);
        sort!"a.w == b.w ? a.v > b.v : a.w < b.w"(rs1);
        foreach (i; 1..rs1.length) rs1[i].v = max(rs1[i].v, rs1[i-1].v);
        run(N/2, N, 0, 0, rs2);
        long res;
        foreach (p; rs2) {
            if (p.w + rs1[0].w <= W) {
                int l, r = rs1.length.to!int;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (p.w + rs1[m].w <= W) {
                        l = m;
                    } else {
                        r = m;
                    }
                }
                res = max(res, p.v + rs1[l].v);
            }
        }
        writeln(res);
    }
}