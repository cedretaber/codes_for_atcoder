import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nuv = readln.split.to!(int[]);
    auto N = nuv[0];
    auto u = nuv[1]-1;
    auto v = nuv[2]-1;

    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        T[A] ~= B;
        T[B] ~= A;
    }
    auto LS = new int[](N);
    void walk(int i, int p, int l) {
        LS[i] = l;
        foreach (j; T[i]) if (j != p) walk(j, i, l+1);
    }
    walk(v, -1, 0);

    int solve(int i, int p, int l) {
        if (l >= LS[i]) return LS[i];
        auto r = LS[i]-1;
        foreach (j; T[i]) if (j != p) {
            r = max(r, solve(j, i, l+1));
        }
        return r;
    }
    writeln(solve(u, -1, 0));
}