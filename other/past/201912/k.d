import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii;

void main()
{
    auto N = readln.chomp.to!int;
    int[][] T;
    T.length = N;
    int root;
    foreach (i; 0..N) {
        auto p = readln.chomp.to!int;
        if (p == -1) {
            root = i;
            continue;
        }
        T[i] ~= p-1;
        T[p-1] ~= i;
    }
    auto DP = new int[](N);
    auto PV = new int[][](N, 18);
    void walk(int i, int p, int l) {
        DP[i] = l;
        PV[i][0] = p;
        foreach (j; T[i]) if (j != p) walk(j, i, l+1);
    }
    walk(root, -1, 0);
    foreach (n; 1..18) {
        foreach (i; 0..N) {
            PV[i][n] = PV[i][n-1] == -1 ? -1 : PV[PV[i][n-1]][n-1];
        }
    }

    int look(int i, int l) {
        if (l == 0) return i;
        foreach (j; 0..18) if (l & (1<<j)) return look(PV[i][j], l - 2^^j);
        return -1;
    }

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        if (DP[a] < DP[b]) {
            writeln("No");
            continue;
        }
        writeln(b == look(a, DP[a] - DP[b]) ? "Yes" : "No");
    }
}