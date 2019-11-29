import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    int[int][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto abl = readln.split.to!(int[]);
        auto A = abl[0]-1;
        auto B = abl[1]-1;
        auto L = abl[2];
        ++G[A][L];
        ++G[B][L];
    }

    int r;
    foreach (ref g; G) {
        bool[2540] fs;
        foreach (l, n; g) if (!fs[l]) {
            auto k = 2540 - l;
            if (k == l) {
                r += n * (n-1) / 2;
            } else if (k in g) {
                r += n * g[k];
            }
            fs[k] = true;
        }
    }
    writeln(r);
}