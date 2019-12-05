import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!int;
    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0]-1;
        auto y = xy[1]-1;
        T[x] ~= y;
        T[y] ~= x;
    }

    if (N == 1) {
        writeln(2);
        return;
    }

    auto DP = new long[][](N, 2);
    foreach (ref dp; DP) dp[] = -1;

    long solve(int i, int p, int b) {
        if (p != -1 && T[i].length == 1) return b == 0 ? 2 : 1;
        if (DP[i][b] == -1) {
            long r = 1;
            foreach (j; T[i]) if (j != p) {
                r = (r * solve(j, i, 0)) % P;
            }
            if (b == 0) {
                long s = 1;
                foreach (j; T[i]) if (j != p) {
                    s = (s * solve(j, i, 1)) % P;
                }
                r = (r + s) % P;
            }
            DP[i][b] = r;
        }
        return DP[i][b];
    }
    writeln(solve(0, -1, 0));
}