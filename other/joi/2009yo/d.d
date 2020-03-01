import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto m = readln.chomp.to!int;
    auto n = readln.chomp.to!int;
    int[][] MAP;
    MAP.length = n;
    foreach (i; 0..n) MAP[i] = readln.split.to!(int[]);

    int r;
    foreach (i; 0..n) foreach (j; 0..m) {
        if (MAP[i][j] == 0) continue;

        auto memo = new bool[][](n, m);
        memo[i][j] = true;
        int solve(int x, int y) {
            int r;
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto xx = x+d[0];
                auto yy = y+d[1];
                if (xx < 0 || xx >= m || yy < 0 || yy >= n || MAP[yy][xx] == 0 || memo[yy][xx]) continue;
                memo[yy][xx] = true;
                r = max(r, solve(xx, yy));
                memo[yy][xx] = false;
            }
            return r + 1;
        }
        r = max(r, solve(j, i));
    }
    writeln(r);
}