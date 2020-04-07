import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto cs = new int[](N);
    int[][] V;
    V.length = N;
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        V[b] ~= a;
        ++cs[a];
    }

    auto ps = new double[][](2, N);
    ps[0][] = 1;
    foreach (n; 0..1000) {
        auto x = n%2, y = (n+1)%2;
        foreach (i; 0..N) {
            ps[y][i] = 0.1;
            foreach (v; V[i]) ps[y][i] += ps[x][v] / cs[v] * 0.9;
        }
    }
    foreach (i; 0..N) writefln("%.10f", ps[1][i]);
}