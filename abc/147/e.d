import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    int[][] AS, BS;
    AS.length = H;
    BS.length = H;
    foreach (i; 0..H) {
        AS[i] = readln.split.to!(int[]);
    }
    foreach (i; 0..H) {
        BS[i] = readln.split.to!(int[]);
    }
    auto DP = new int[][][](H, W, 80*80+1);
    foreach_reverse (h; 0..H) {
        foreach_reverse (w; 0..W) {
            foreach (d; 0..80*80+1) {
                auto e = abs(AS[h][w] - BS[h][w]);
                auto dpe = d + e;
                auto dme = abs(d - e);
                if (h+1 == H && w+1 == W) {
                    DP[h][w][d] = dme;
                    continue;
                }
                auto r = int.max;
                if (h+1 < H) {
                    if (dpe <= 80*80) r = min(r, DP[h+1][w][dpe]);
                    if (dme <= 80*80) r = min(r, DP[h+1][w][dme]);
                }
                if (w+1 < W) {
                    if (dpe <= 80*80) r = min(r, DP[h][w+1][dpe]);
                    if (dme <= 80*80) r = min(r, DP[h][w+1][dme]);
                }
                DP[h][w][d] = r;
            }
        }
    }
    writeln(DP[0][0][0]);
}