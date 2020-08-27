import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "to", int, "l");

void main()
{
    auto nmk = readln.split.to!(int[]);
    auto N = nmk[0];
    auto M = nmk[1];
    auto K = nmk[2];
    int[] as, bs, ls;
    auto T = new P[][N];
    foreach (_; 0..M) {
        auto abl = readln.split.to!(int[]);
        auto a = abl[0]-1;
        auto b = abl[1]-1;
        auto l = abl[2];
        as ~= a;
        bs ~= b;
        ls ~= l;
        T[a] ~= P(b, l);
        T[b] ~= P(a, l);
    }

    auto DP = new int[](N);
    DP[] = int.max/3;
    auto ps = new int[](N);
    ps[] = -1;
    P[] ss;
    foreach (_; 0..K) {
        auto s = readln.chomp.to!int-1;
        DP[s] = 0;
        ss ~= P(s, 0);
    }
    auto Q = heapify!"a.l > b.l"(ss);
    while (!Q.empty) {
        auto i = Q.front.to;
        auto l = Q.front.l;
        Q.popFront();
        foreach (n; T[i]) if (DP[n.to] > l + n.l) {
            DP[n.to] = l + n.l;
            ps[n.to] = i;
            Q.insert(P(n.to, l + n.l));
        }
    }

    int r;
    foreach (l; DP) r = max(r, l);
    foreach (i; 0..M) {
        auto a = as[i];
        auto b = bs[i];
        auto l = ls[i];
        if (ps[a] != b && ps[b] != a) {
            auto d = abs(DP[a] - DP[b]);
            if (l - d <= 0) continue;
            r = max(r, max(DP[a], DP[b]) + (l-d+1)/2);
        }
    }

    writeln(r);
}