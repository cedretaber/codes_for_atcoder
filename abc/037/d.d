import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

enum P = 10L^^9+7;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    int[][] MAP, MEMO;
    MAP.length = H;
    MEMO.length = H;
    foreach (i; 0..H) {
        MAP[i].length = W;
        MEMO[i].length = W;
    }

    foreach (h; 0..H) {
        foreach (w, n; readln.split.to!(int[])) MAP[h][w] = n;
    }
    foreach (h; 0..H) {
        foreach (w; 0..W) MEMO[h][w] = -1;
    }

    int solve(int h, int w) {
        if (MEMO[h][w] != -1) return MEMO[h][w];
        int s = 1;
        foreach (xy; [[1, 0], [-1, 0], [0, 1], [0, -1]]) {
            auto x = w + xy[0];
            auto y = h + xy[1];
            if (x < 0 || x >= W || y < 0 || y >= H) continue;
            if (MAP[y][x] <= MAP[h][w]) continue;
            s = ((s.to!long + solve(y, x).to!long) % P).to!int;
        }
        return MEMO[h][w] = s;
    }

    int r;
    foreach_reverse (h; 0..H) {
        foreach (w; 0..W) {
            if (MEMO[h][w] == -1) solve(h, w);
            r = ((r.to!long + MEMO[h][w].to!long) % P).to!int;
        }
    }
    writeln(r);
}