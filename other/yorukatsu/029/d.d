import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto us = new int[][](H, W);
    auto ds = new int[][](H, W);
    auto ls = new int[][](H, W);
    auto rs = new int[][](H, W);
    foreach (i; 0..H) {
        foreach (j, c; readln.chomp) if (c == '#') {
            us[i][j] = -1;
            ds[i][j] = -1;
            ls[i][j] = -1;
            rs[i][j] = -1;
        }
    }
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (i+1 < H && ds[i+1][j] != -1) ds[i+1][j] = ds[i][j] + 1;
            auto ii = H-i-1;
            if (ii-1 >= 0 && us[ii-1][j] != -1) us[ii-1][j] = us[ii][j] + 1;

            if (j+1 < W && rs[i][j+1] != -1) rs[i][j+1] = rs[i][j] + 1;
            auto jj = W-j-1;
            if (jj-1 >= 0 && ls[i][jj-1] != -1) ls[i][jj-1] = ls[i][jj] + 1;
        }
    }
    int r;
    foreach (i; 0..H) foreach (j; 0..W) if (us[i][j] != -1) r = max(r, us[i][j] + ds[i][j] + ls[i][j] + rs[i][j] + 1);
    writeln(r);
}