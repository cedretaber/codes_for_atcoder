import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[100][100] CW;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    char[][] MAP;
    MAP.length = H;
    foreach (i; 0..H) MAP[i] = readln.chomp.to!(char[]);

    void solve(int h, int w) {
        if (MAP[h][w] == '#') {
            CW[h][w] = 1;
            return;
        }
        if (h+1 < H) {
            if (CW[h+1][w] == 0) solve(h+1, w);
            if (CW[h+1][w] == -1) {
                CW[h][w] = 1;
                return;
            }
        }
        if (w+1 < W) {
            if (CW[h][w+1] == 0) solve(h, w+1);
            if (CW[h][w+1] == -1) {
                CW[h][w] = 1;
                return;
            }
        }
        if (h+1 < H && w+1 < W) {
            if (CW[h+1][w+1] == 0) solve(h+1, w+1);
            if (CW[h+1][w+1] == -1) {
                CW[h][w] = 1;
                return;
            }
        }
        CW[h][w] = -1;
    }
    solve(0, 0);
    writeln(CW[0][0] == 1 ? "First" : "Second");
}