import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    int[][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        G[A] ~= B;
        G[B] ~= A;
    }

    auto es = new int[](N);
    long x, y, z;
    void walk(int i, int p, int c) {
        c = c == 1 ? 2 : 1;
        foreach (j; G[i]) if (j != p) {
            if (z) return;
            if (es[j] == 0) {
                if (c == 1) {
                    ++x;
                } else {
                    ++y;
                }
                es[j] = c;
                walk(j, i, c);
            } else if ((es[j] == 1 && c == 2) || es[j] == 2 && c == 1) {
                z = 1;
                return;
            }
        }
    }
    es[0] = 1;
    ++x;
    walk(0, -1, 1);

    if (z) {
        writeln(N * (N-1) / 2 - M);
    } else {
        writeln(x * y - M);
    }
}