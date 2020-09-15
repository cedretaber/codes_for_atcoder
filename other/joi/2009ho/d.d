import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto hwn = readln.split.to!(int[]);
    auto H = hwn[0];
    auto W = hwn[1];
    auto N = hwn[2];
    int[][] MAP;
    foreach (_; 0..H) MAP ~= readln.split.to!(int[]);

    auto DP = new int[][](H+1, W+1);
    DP[0][0] = N-1;
    foreach (i; 0..H) foreach (j; 0..W) {
        auto x = DP[i][j]/2;
        DP[i+1][j] += x;
        DP[i][j+1] += x;
        if (DP[i][j]%2 == 1) {
            if (MAP[i][j] == 0) {
                DP[i+1][j] += 1;
            } else {
                DP[i][j+1] += 1;
            }
        }
    }
    foreach (i; 0..H) foreach (j; 0..W) if (DP[i][j]%2 == 1) MAP[i][j] = MAP[i][j] == 0 ? 1 : 0;
    int x, y;
    while (x < W && y < H) {
        if (MAP[y][x] == 0) {
            ++y;
        } else {
            ++x;
        }
    }
    writeln(y+1, " ", x+1);
}