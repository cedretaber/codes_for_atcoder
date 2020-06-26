import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias P = Tuple!(int, "to", long, "c");

void main()
{
    auto nl = readln.split.to!(int[]);
    auto N = nl[0];
    auto L = nl[1];

    auto G = new P[][L+1];
    foreach (i; 0..L) G[i+1] ~= P(i, 0);
    foreach (_; 0..N) {
        auto lrc = readln.split.to!(int[]);
        auto l = lrc[0];
        auto r = lrc[1];
        auto c = lrc[2];
        G[l] ~= P(r, c);
    }
    auto Q = heapify!"a.c > b.c"([P(0, 0)]);
    auto DS = new long[](L+1);
    DS[] = long.max;
    DS[0] = 0;
    while (!Q.empty) {
        auto i = Q.front.to;
        auto c = Q.front.c;
        Q.removeFront();
        if (DS[i] < c) continue;
        foreach (n; G[i]) if (DS[n.to] > c + n.c) {
            DS[n.to] = c + n.c;
            Q.insert(P(n.to, c + n.c));
        }
    }
    writeln(DS[L]);
}