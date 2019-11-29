import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5] G, T;
bool[10^^5] F, U;
int[10^^5] P, FROM;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        G[a] ~= b;
        G[b] ~= a;
    }
    if (M%2 == 1) {
        writeln(-1);
        return;
    }
    int[2][] rr;
    int[] ss = [0];
    F[0] = true;
    while (!ss.empty) {
        auto h = ss[0];
        U[h] = true;
        ss = ss[1..$];
        foreach (n; G[h]) {
            if (F[n]) {
                if (P[h] != n && U[n]) {
                    FROM[n] += 1;
                    rr ~= [n, h];
                }
            } else {
                F[n] = true;
                T[h] ~= n;
                P[n] = h;
                ss ~= n;
            }
        }
    }
    void solve(int i, int p) {
        foreach (n; T[i]) solve(n, i);
        if (i == p) return;
        if (FROM[i]%2 == 1) {
            rr ~= [i, p];
        } else {
            FROM[p] += 1;
            rr ~= [p, i];
        }
    }
    solve(0, 0);
    foreach (r; rr) writefln("%d %d", r[0]+1, r[1]+1);
}