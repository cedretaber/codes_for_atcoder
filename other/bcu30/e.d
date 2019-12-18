import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nkq = readln.split.to!(int[]);
    auto N = nkq[0];
    auto K = nkq[1];
    auto Q = nkq[2];
    char[][] SS;
    SS.length = N;
    foreach (i; 0..N) SS[i] = readln.chomp.to!(char[]);
    auto DP = new int[][](N, N);
    foreach (i; 0..N) {
        foreach_reverse (j; 0..N) {
            if (SS[i][j] == '#') {
                DP[i][j] = 0;
            } else if (j != N-1) {
                DP[i][j] = DP[i][j+1] + 1;
            } else {
                DP[i][j] = 1;
            }
        }
    }
    foreach_reverse (i; 0..N) {
        foreach (j; 0..N) {
            if (i == N-1) {
                DP[i][j] = SS[i][j] == '#' ? 0 : 1;
            } else {
                DP[i][j] = min(DP[i][j], DP[i+1][j] + 1);
            }
        }
    }
    foreach_reverse (i; 0..N-1) {
        foreach_reverse (j; 0..N-1) {
            DP[i][j] = min(DP[i][j], DP[i+1][j+1] + 1);
        }
    }

    auto MAP = new int[][](N, N);
    int c;
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (MAP[i][j] || DP[i][j] < K) continue;
            MAP[i][j] = ++c;
            auto ss = [[i, j]];
            while (!ss.empty) {
                auto y = ss[0][0];
                auto x = ss[0][1];
                ss = ss[1..$];
                foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                    auto dy = y + d[0];
                    auto dx = x + d[1];
                    if (dx < 0 || dx >= N || dy < 0 || dy >= N || DP[dy][dx] < K || MAP[dy][dx]) continue;
                    MAP[dy][dx] = c;
                    ss ~= [dy, dx];
                }
            }
        }
    }

    foreach (_; 0..Q) {
        auto rc = readln.split.to!(int[]);
        auto ry = rc[0]-1;
        auto rx = rc[1]-1;
        auto cy = rc[2]-1;
        auto cx = rc[3]-1;
        writeln(MAP[ry][rx] && MAP[ry][rx] == MAP[cy][cx] ? "Yes" : "No");
    }
}