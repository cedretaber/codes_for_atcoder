import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "to", long, "c");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto G = new P[][N];
    foreach (i; 1..N) {
        G[i] ~= P(i-1, 0);
    }
    foreach (_; 0..M) {
        auto lrc = readln.split.to!(int[]);
        auto L = lrc[0]-1;
        auto R = lrc[1]-1;
        long C = lrc[2];
        G[L] ~= P(R, C);
    }

    auto Q = heapify!"a.c > b.c"([P(0, 0)]);
    auto DP = new long[](N);
    DP[] = long.max/3;
    DP[0] = 0;
    while (!Q.empty) {
        auto i = Q.front.to;
        auto c = Q.front.c;
        Q.popFront();
        if (DP[i] < c) continue;
        foreach (n; G[i]) if (DP[n.to] > c + n.c) {
            DP[n.to] = c + n.c;
            Q.insert(P(n.to, c + n.c));
        }
    }
    writeln(DP[N-1] == long.max/3 ? -1 : DP[N-1]);
}