import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias P = Tuple!(int, "to", int, "d");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto st = readln.split.to!(int[]);
    auto S = st[0]-1;
    auto T = st[1]-1;

    P[][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto xyd = readln.split.to!(int[]);
        auto x = xyd[0]-1;
        auto y = xyd[1]-1;
        auto d = xyd[2];
        G[x] ~= P(y, d);
        G[y] ~= P(x, d);
    }

    void walk(int s, ref int[] ss) {
        ss[] = int.max;
        ss[s] = 0;
        auto Q = heapify!"a.d > b.d"([P(s, 0)]);
        while (!Q.empty) {
            auto h = Q.front; Q.removeFront();
            if (h.d > ss[h.to]) continue;
            foreach (n; G[h.to]) {
                if (ss[n.to] <= n.d + h.d) continue;
                ss[n.to] = n.d + h.d;
                Q.insert(P(n.to, n.d + h.d));
            }
        }
    }

    auto ss = new int[](N);
    walk(S, ss);
    auto tt = new int[](N);
    walk(T, tt);
    foreach (i; 0..N) if (ss[i] == tt[i] && ss[i] != int.max) {
        writeln(i+1);
        return;
    }
    writeln(-1);
}