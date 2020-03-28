import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nw = readln.split.to!(long[]);
    auto N = nw[0];
    auto W = nw[1];

    long[] vs, ws;
    long max_v, max_w;
    foreach (_; 0..N) {
        auto vw = readln.split.to!(long[]);
        auto v = vw[0];
        auto w = vw[1];
        vs ~= v;
        ws ~= w;
        max_v = max(max_v, v);
        max_w = max(max_w, w);
    }

    if (max_w <= 1000) {
        auto DP = new long[][](N+1, max_w*N+1);
        foreach (i; 0..N) {
            foreach (w; 0..max_w*N+1) {
                DP[i+1][w] = max(DP[i][w], DP[i+1][w]);
                if (w + ws[i] <= max_w*N && w + ws[i] <= W) DP[i+1][w+ws[i]] = max(DP[i+1][w+ws[i]], DP[i][w] + vs[i]);
            }
        }
        long r;
        foreach (w; 0..max_w*N+1) r = max(r, DP[N][w]);
        writeln(r);
    } else if (max_v <= 1000) {
        auto DP = new long[][](N+1, max_v*N+1);
        foreach (ref dp; DP) dp[] = long.max/3;
        DP[0][0] = 0;
        foreach (i; 0..N) {
            foreach (v; 0..max_v*N+1) {
                if (DP[i][v] > W) continue;
                DP[i+1][v] = min(DP[i][v], DP[i+1][v]);
                if (DP[i][v] + ws[i] <= W) DP[i+1][v+vs[i]] = min(DP[i+1][v+vs[i]], DP[i][v] + ws[i]);
            }
        }
        foreach_reverse (v; 1..max_v*N+1) if (DP[N][v] <= W) {
            writeln(v);
            return;
        }
        writeln(0);
    } else if (N == 1) {
        writeln(ws[0] <= W ? vs[0] : 0);
    } else {
        alias VW = Tuple!(long, "v", long, "w");
        max_v = 0;
        void make(long i, long j, long v, long w, ref VW[] vws) {
            if (i == j) return;
            make(i+1, j, v, w, vws);
            v += vs[i];
            w += ws[i];
            if (w <= W) {
                max_v = max(max_v, v);
                vws ~= VW(v, w);
                make(i+1, j, v, w, vws);
            }
        }
        VW[] vw1 = [VW(0, 0)], vw2 = [VW(0, 0)];
        make(0, N/2, 0, 0, vw1);
        make(N/2, N, 0, 0, vw2);
        sort!"a.w < b.w"(vw2);
        auto v2_max = new long[](vw2.length);
        v2_max[0] = vw2[0].v;
        foreach (i; 1..vw2.length) v2_max[i] = max(v2_max[i-1], vw2[i].v);
        foreach (vw; vw1) {
            if (vw.w + vw2[0].w > W) continue;
            if (vw.w + vw2[$-1].w <= W) {
                max_v = max(max_v, vw.v + v2_max[$-1]);
                continue;
            }
            size_t l, r = vw2.length;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (vw.w + vw2[m].w <= W) {
                    l = m;
                } else {
                    r = m;
                }
            }
            max_v = max(max_v, vw.v + v2_max[l]);
        }
        writeln(max_v);
    }
}