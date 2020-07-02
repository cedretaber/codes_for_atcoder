import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, core.bitop;

void main()
{
    auto N = readln.chomp.to!long;
    auto T = new int[][](N, N);
    foreach (i; 1..N.to!int) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a][b] = i;
        T[b][a] = i;
    }
    auto M = readln.chomp.to!long;
    auto RS = new ulong[](M);
    foreach (i; 0..M) {
        auto uv = readln.split.to!(int[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        int[] walk(int i, int p) {
            if (i == v) return [-1];
            foreach (j; 0..N.to!int) if (j != p && T[i][j]) {
                auto s = walk(j, i);
                if (!s.empty) {
                    return s ~ T[i][j];
                }
            }
            return [];
        }
        foreach (e; walk(u, -1)[1..$]) RS[i] |= (1L<<e);
    }

    long res = 2L^^(N-1);
    foreach (x; 1..(1<<M)) {
        ulong s;
        foreach (i; 0..M) if (x & (1<<i)) s |= RS[i];
        res += 2L^^(N-1-popcnt(s)) * (-1)^^popcnt(x);
    }
    writeln(res);
}