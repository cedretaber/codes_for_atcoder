import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto MAP = new char[][](N, M);
    int sx, sy, gx, gy;
    foreach (i; 0..N) {
        foreach (j, c; readln.chomp) {
            if (c == 'S') {
                sx = j.to!int;
                sy = i;
            }
            if (c == 'G') {
                gx = j.to!int;
                gy = i;
            }
            MAP[i][j] = c;
        }
    }

    auto DP = new bool[][][](N, M, 10);
    DP[sy][sx][0] = 0;
    auto ss = [[sx, sy, 0]];
    int t;
    while (!ss.empty) {
        ++t;
        int[][] nss;
        foreach (s; ss) {
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto x = s[0] + d[0];
                auto y = s[1] + d[1];
                if (x < 0 || x >= M || y < 0 || y >= N) continue;
                auto c = s[2];
                if (c+1 == MAP[y][x] - '0') c += 1;
                if (x == gx && y == gy && c == 9) {
                    writeln(t);
                    return;
                }
                if (DP[y][x][c]) continue;
                DP[y][x][c] = true;
                nss ~= [x, y, c];
            }
        }
        ss = nss;
    }
    writeln(-1);
}