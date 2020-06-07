import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.container;

alias X = Tuple!(int, "i", long, "c");
alias Y = Tuple!(uint, "s", int, "i", long, "c");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto G = new int[][N];
    foreach (_; 0..M) {
        auto uv = readln.split.to!(int[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        G[u] ~= v;
        G[v] ~= u;
    }

    auto s = readln.chomp.to!int - 1;
    auto K = readln.chomp.to!int;
    auto ts = readln.split.to!(int[]).map!"a - 1".array();

    auto ds = new long[](K);
    {
        auto cs = new long[](N);
        cs[] = long.max/3;
        cs[s] = 0;

        auto Q = heapify!"a.c > b.c"([X(s, 0)]);
        while (!Q.empty) {
            auto h = Q.front;
            Q.popFront();
            if (cs[h.i] < h.c) continue;
            foreach (j; G[h.i]) if (cs[j] > h.c + 1) {
                cs[j] = h.c + 1;
                Q.insert(X(j, h.c + 1));
            }
        }

        foreach (i, t; ts) ds[i] = cs[t];
    }

    auto ms = new long[][](K, K);
    foreach (k, t; ts) {
        auto cs = new long[](N);
        cs[] = long.max/3;
        cs[t] = 0;

        auto Q = heapify!"a.c > b.c"([X(t, 0)]);
        while (!Q.empty) {
            auto h = Q.front;
            Q.popFront();
            if (cs[h.i] < h.c) continue;
            foreach (j; G[h.i]) if (cs[j] > h.c + 1) {
                cs[j] = h.c + 1;
                Q.insert(X(j, h.c + 1));
            }
        }

        foreach (i, tt; ts) ms[k][i] = cs[tt];
    }

    auto DP = new long[][](1<<K, K);
    foreach (ref dp; DP) dp[] = long.max/3;

    Y[] ss;
    foreach (i, _; ts) {
        ss ~= Y(1U<<i, i.to!int, ds[i]);
        DP[1U<<i][i] = ds[i];
    }

    while (!ss.empty) {
        auto h = ss[0];
        ss = ss[1..$];
        if (DP[h.s][h.i] < h.c) continue;
        foreach (j; 0..K) if (DP[h.s | (1U<<j)][j] > h.c + ms[h.i][j]) {
            DP[h.s | (1U<<j)][j] = h.c + ms[h.i][j];
            ss ~= Y(h.s | (1U<<j), j, h.c + ms[h.i][j]);
        }
    }

    auto r = long.max;
    foreach (i; 0..K) r = min(r, DP[(1<<K)-1][i]);
    writeln(r);
}