import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "to", long, "d");

void main()
{
    auto nmc = readln.split.to!(int[]);
    auto N = nmc[0];
    auto M = nmc[1];
    long C = nmc[2];
    auto G = new P[][N];
    long d_sum;
    foreach (_; 0..M) {
        auto abd = readln.split.to!(int[]);
        auto A = abd[0]-1;
        auto B = abd[1]-1;
        long D = abd[2];
        G[A] ~= P(B, D);
        G[B] ~= P(A, D);
        d_sum += D;
    }

    auto DP = new P[](N);
    foreach (i, ref p; DP) p = P(i.to!int, long.max/3);
    DP[0].d = 0;
    auto Q = heapify!"a.d > b.d"([P(0, 0)]);
    while (!Q.empty) {
        auto i = Q.front.to;
        auto d = Q.front.d;
        Q.popFront();
        foreach (n; G[i]) if (DP[n.to].d > d + n.d) {
            DP[n.to].d = d + n.d;
            Q.insert(P(n.to, d + n.d));
        }
    }
    sort!"a.d < b.d"(DP);
    auto memo = [0: true];
    long r = d_sum;
    foreach (p; DP) {
        memo[p.to] = true;
        foreach (q; G[p.to]) if (q.to in memo) d_sum -= q.d;
        r = min(r, C * p.d + d_sum);
    }
    writeln(r);
}