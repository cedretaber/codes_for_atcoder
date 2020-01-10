import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

bool[2*10^^3][2*10^^3] MAP;
int[2*10^^3][2*10^^3] US, MS, HS, SS;

void main()
{
    auto LS = [US, MS, HS, SS];
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (n; 0..N) {
        auto line = readln;
        foreach (m; 0..M) {
            MAP[n][m] = line[m] == '#';
        }
    }

    foreach (n; 0..N) {
        foreach (m; 0..M) {
            LS[3][n][m] = m == 0 || MAP[n][m-1] ? 0 : LS[3][n][m-1] + 1;
        }
        foreach_reverse (m; 0..M) {
            LS[1][n][m] = m == M-1 || MAP[n][m+1] ? 0 : LS[1][n][m+1] + 1;
        }
    }
    foreach (m; 0..M) {
        foreach (n; 0..N) {
            LS[0][n][m] = n == 0 || MAP[n-1][m] ? 0 : LS[0][n-1][m] + 1;
        }
        foreach_reverse (n; 0..N) {
            LS[2][n][m] = n == N-1 || MAP[n+1][m] ? 0 : LS[2][n+1][m] + 1;
        }
    }

    long cnt;
    foreach (n; 0..N) {
        foreach (m; 0..M) {
            if (MAP[n][m]) continue;
            foreach (x; 0..4) {
                cnt += LS[x][n][m] * LS[(x+1)%4][n][m];
            }
        }
    }
    writeln(cnt);
}