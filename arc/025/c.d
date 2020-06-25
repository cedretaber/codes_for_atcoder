import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias P = Tuple!(int, "to", long, "d");

void main()
{
    auto nmrt = readln.split.to!(int[]);
    auto N = nmrt[0];
    auto M = nmrt[1];
    long R = nmrt[2];
    long T = nmrt[3];
    auto G = new P[][N];
    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto a = abc[0]-1;
        auto b = abc[1]-1;
        auto c = abc[2];
        G[a] ~= P(b, c);
        G[b] ~= P(a, c);
    }

    long res;
    auto DS = new long[](N);
    foreach (a; 0..N) {
        DS[] = long.max;
        DS[a] = 0;
        auto Q = heapify!"a.d > b.d"([P(a, 0)]);
        while (!Q.empty) {
            auto i = Q.front.to;
            auto d = Q.front.d;
            Q.removeFront();
            if (DS[i] < d) continue;
            foreach (n; G[i]) if (DS[n.to] > d + n.d) {
                DS[n.to] = d + n.d;
                Q.insert(P(n.to, d + n.d));
            }
        }
        sort!"a < b"(DS);
        foreach (c; 1..N) {
            auto d1 = DS[c];
            if (d1 * R >= DS[$-1] * T) break;
            if (d1 * R < DS[1] * T) {
                res += N-2;
                continue;
            }
            auto l = 0, r = N-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (d1 * R >= DS[m] * T) {
                    l = m;
                } else {
                    r = m;
                }
            }
            if (r <= c) ++r;
            res += N - r;
        }
    }
    writeln(res);
}