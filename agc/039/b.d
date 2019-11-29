import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    bool[][] G;
    G.length = N;
    foreach (i; 0..N) {
        G[i].length = N;
        foreach (j, x; readln.chomp) {
            if (x == '1') G[i][j] = true;
        }
    }

    auto S = new int[](N);
    bool check(int i, int p, int s) {
        if (S[i]) return S[i] == s;
        S[i] = s;
        foreach (j, n; G[i]) if (n && i != j && j != p) {
            if (check(j.to!int, i, s%2+1) == false) return false;
        }
        return true;
    }
    if (check(0, -1, 1) == false) {
        writeln(-1);
        return;
    }

    auto M = new int[][](N, N);
    foreach (i; 0..N) {
        foreach (j, c; G[i]) {
            if (i == j) continue;
            if (c) {
                M[i][j] = 1;
                M[j][i] = 1;
            } else {
                M[i][j] = int.max / 3;
                M[j][i] = int.max / 3;
            }
        }
    }
    foreach (k; 0..N) {
        foreach (i; 0..N) {
            foreach (j; 0..N) {
                if (M[i][j] > M[i][k] + M[k][j]) {
                    M[i][j] = M[i][k] + M[k][j];
                }
            }
        }
    }
    int r;
    foreach (i; 0..N) foreach (j; 0..N) r = max(r, M[i][j]);
    writeln(r+1);
}