import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.range, std.container;

alias C = Tuple!(int, "s", int, "e");
alias P = Tuple!(int, "to", int, "h");

void main()
{
    auto N = readln.chomp.to!int;
    auto hs = readln.split.to!(int[]);
    auto CS = new C[][N];
    int[] ts;
    foreach (_; 0..N) {
        auto mse = readln.split.to!(int[]);
        auto M = mse[0]-1;
        auto S = mse[1];
        auto E = mse[2];
        CS[M] ~= C(S, E);
        ts ~= S;
        ts ~= E;
    }

    sort(ts);
    ts.uniq();
    auto len = ts.length.to!int;

    int[int] t2i;
    foreach (i, t; ts) t2i[t] = i.to!int;
    foreach (ref C; CS) foreach (ref c; C) {
        c.s = t2i[c.s];
        c.e = t2i[c.e];
    }

    auto G = new P[][len];
    foreach (i; 0..len-1) G[i] ~= P(i+1, 0);
    foreach (ref C; CS) {
        if (C.empty) continue;
        sort!"a.e < b.e"(C);
        foreach (i; 0..C.length) {
            auto s = C[i].s;
            auto k = i;
            int e, h;
            foreach (j; i..C.length) {
                if (C[j].s < e) continue;
                h += hs[k-i];
                G[s] ~= P(C[j].e, h);
                e = C[j].e;
                ++k;
            }
        }
    }

    auto Q = heapify!"a.h < b.h"([P(0, 0)]);
    auto DP = new int[](len);
    DP[] = -1;
    while (!Q.empty) {
        auto i = Q.front.to;
        auto h = Q.front.h;
        Q.removeFront();
        if (DP[i] > h) continue;
        foreach (p; G[i]) if (DP[p.to] < h + p.h) {
            DP[p.to] = h + p.h;
            Q.insert(P(p.to, h + p.h));
        }
    }
    writeln(DP[len-1]);
}