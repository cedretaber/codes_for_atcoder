import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[][100] G;
int[100] F;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..M) {
        auto uv = readln.split.to!(int[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        G[u] ~= v;
        G[v] ~= u;
    }

    bool walk(int i, int p) {
        F[i] = true;
        auto t = true;
        foreach (n; G[i]) if (n != p) {
            if (F[n] || walk(n, i) == false) {
                t = false;
            }
        }
        return t;
    }

    int r;
    foreach (i; 0..N) {
        if (F[i]) continue;
        if (walk(i, -1)) ++r;
    }
    writeln(r);
}