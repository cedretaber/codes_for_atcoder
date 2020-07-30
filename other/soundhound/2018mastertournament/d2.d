import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "to", long, "a", long, "b");
alias S = Tuple!(int, "i", long, "c");

void main()
{
    auto nmst = readln.split.to!(int[]);
    auto N = nmst[0];
    auto M = nmst[1];
    auto s = nmst[2]-1;
    auto t = nmst[3]-1;
    
    auto G = new P[][N];
    foreach (_; 0..M) {
        auto uvab = readln.split.to!(int[]);
        auto u = uvab[0]-1;
        auto v = uvab[1]-1;
        long a = uvab[2];
        long b = uvab[3];

        G[u] ~= P(v, a, b);
        G[v] ~= P(u, a, b);
    }

    auto DP1 = new long[](N);
    DP1[] = long.max/3;
    DP1[s] = 0;
    auto Q = heapify!"a.c > b.c"([S(s, 0)]);
    while (!Q.empty) {
        auto i = Q.front.i;
        auto c = Q.front.c;
        Q.removeFront();
        if (DP1[i] < c) continue;
        foreach (n; G[i]) if (DP1[n.to] > c + n.a) {
            DP1[n.to] = c + n.a;
            Q.insert(S(n.to, c + n.a));
        }
    }

    auto DP2 = new long[](N);
    DP2[] = long.max/3;
    DP2[t] = 0;
    Q = heapify!"a.c > b.c"([S(t, 0)]);
    while (!Q.empty) {
        auto i = Q.front.i;
        auto c = Q.front.c;
        Q.removeFront();
        if (DP2[i] < c) continue;
        foreach (n; G[i]) if (DP2[n.to] > c + n.b) {
            DP2[n.to] = c + n.b;
            Q.insert(S(n.to, c + n.b));
        }
    }

    S[] cs;
    foreach (i; 0..N) {
        cs ~= S(i, DP1[i] + DP2[i]);
    }
    sort!"a.c < b.c"(cs);
    foreach (i; 0..N) {
        while (cs[0].i < i) cs = cs[1..$];
        writeln(10L^^15 - cs[0].c);
    }
}