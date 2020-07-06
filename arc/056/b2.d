import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "i", int, "max_i");

void main()
{
    auto nms = readln.split.to!(int[]);
    auto N = nms[0];
    auto M = nms[1];
    auto S = nms[2]-1;

    auto G = new int[][N];
    foreach (_; 0..M) {
        auto uv = readln.split.to!(int[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        G[u] ~= v;
        G[v] ~= u;
    }

    auto DP = new int[](N);
    DP[S] = S;

    auto Q = heapify!"a.max_i < b.max_i"([P(S, S)]);
    while (!Q.empty) {
        auto i = Q.front.i;
        auto max_i = Q.front.max_i;
        Q.removeFront();
        if (DP[i] > min(i, max_i)) continue;
        DP[i] = min(i, max_i);
        foreach (j; G[i]) if (DP[j] < min(j, DP[i])) Q.insert(P(j, DP[i]));
    }
    foreach (i; 0..N) if (DP[i] == i) writeln(i+1);
}