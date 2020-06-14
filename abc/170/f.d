import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

/*

N:0
W:1
S:2
E:3

*/

void main()
{
    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];
    auto xy = readln.split.to!(int[]);
    auto sy = xy[0]-1;
    auto sx = xy[1]-1;
    auto gy = xy[2]-1;
    auto gx = xy[3]-1;

    auto MAP = new char[][H];
    foreach (i; 0..H) MAP[i] = readln.chomp.to!(char[]);

    auto G = new int[][][](H, W, 4);
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (MAP[i][j] == '@') continue;
            if (i > 0 && MAP[i-1][j] != '@') {
                G[i][j][0] = G[i-1][j][0] + 1;
            }
            if (j > 0 && MAP[i][j-1] != '@') {
                G[i][j][1] = G[i][j-1][1] + 1;
            }
        }
    }
    foreach_reverse (i; 0..H) {
        foreach_reverse (j; 0..W) {
            if (MAP[i][j] == '@') continue;
            if (i < H-1 && MAP[i+1][j] != '@') {
                G[i][j][2] = G[i+1][j][2] + 1;
            }
            if (j < W-1 && MAP[i][j+1] != '@') {
                G[i][j][3] = G[i][j+1][3] + 1;
            }
        }
    }

    auto DP = new int[][](H, W);
    foreach (ref dp; DP) dp[] = int.max;

    auto ss = [[sx, sy, 0, -1]];
    while (!ss.empty) {
        auto h = ss[0];
        ss = ss[1..$];
        auto x = h[0];
        auto y = h[1];
        auto c = h[2];
        auto p = h[3];

        foreach (i, d; [[0, -1], [-1, 0], [0, 1], [1, 0]]) {
            if (G[y][x][i] == 0) continue;
            if ((i == 0 && p == 2) || (i == 1 && p == 3) || (i == 2 && p == 0) || (i == 3 && p == 1)) continue;
            foreach (n; 1..min(K+1, G[y][x][i]+1)) {
                auto dx = x + n * d[0];
                auto dy = y + n * d[1];
                if (DP[dy][dx] <= c) continue;
                DP[dy][dx] = c;

                if (dx == gx && dy == gy) {
                    writeln(c+1);
                    return;
                }

                ss ~= [dx, dy, c+1, i.to!int];
            }
        }
    }
    writeln(-1);
}