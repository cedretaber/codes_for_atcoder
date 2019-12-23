import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "h", int, "w");

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    int[][] MAP;
    MAP.length = H;
    foreach (i; 0..H) MAP[i] = readln.split.to!(int[]);
    auto ps = new P[](H * W);
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            ps[MAP[i][j]-1] = P(i, j);
        }
    }

    auto MEMO = new int[][](H, W);
    auto RES = new bool[][](H, W);
    int r;
    void walk(int i, int j, int p) {
        if (MEMO[i][j] != 0 && MEMO[i][j] != p) {
            RES[i][j] = true;
            ++r;
        }
        MEMO[i][j] = p;
        foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
            auto a = i + d[0];
            auto b = j + d[1];
            if (a < 0 || a >= H || b < 0 || b >= W) continue;
            if (MAP[a][b] < MAP[i][j]) continue;
            if (RES[a][b]) continue;
            if (MEMO[a][b] == p) continue;
            walk(a, b, p);
        }
    }
    foreach (i, p; ps) if (MEMO[p.h][p.w] == 0) walk(p.h, p.w, i.to!int + 1);
    writeln(r);
}