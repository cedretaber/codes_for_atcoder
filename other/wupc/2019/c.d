import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    int[][] G;
    G.length = N;
    auto M = nm[1];
    foreach (_; 0..M) {
        auto uv = readln.split.to!(int[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        G[u] ~= v;
        G[v] ~= u;
    }
    auto F = new bool[](N);
    auto R = new int[](N);
    bool walk(int i) {
        F[i] = true;
        int[] cs;
        foreach (j; G[i]) if (!F[j]) {
            if (walk(j)) cs ~= j;
        }
        if (cs.empty) {
            if (i != 0) return true;
            foreach (j; G[i]) {
                auto n = R[j]-1;
                foreach (k; G[j]) if (k == n) {
                    R[i] = n+1;
                    R[j] = i+1;
                    return false;
                }
            }
        }
        foreach (j, c; cs) {
            if (j == 0) {
                R[i] = c+1;
            } else {
                R[cs[j-1]] = c+1;
            }
        }
        R[cs[$-1]] = i+1;
        return false;
    }
    walk(0);
    writeln(R.to!(string[]).join(" "));
}