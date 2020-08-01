import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    int[][] MAP;
    foreach (_; 0..H) MAP ~= readln.split.to!(int[]);

    auto DP = new long[][][](W, W, 8);
    foreach (i; 0..H) foreach (j; 0..W-1) foreach (k; j+1..W) {
        ++DP[j][k][(1<<MAP[i][j]) | (1<<MAP[i][k])];
    }
    long r;
    foreach (i; 0..W-1) foreach (j; i+1..W) {
        r += DP[i][j][0b001] * DP[i][j][0b110];
        r += DP[i][j][0b010] * DP[i][j][0b101];
        r += DP[i][j][0b100] * DP[i][j][0b011];
        r += DP[i][j][0b110] * (DP[i][j][0b001] + DP[i][j][0b101] + DP[i][j][0b011]);
        r += DP[i][j][0b101] * (DP[i][j][0b010] + DP[i][j][0b110] + DP[i][j][0b011]);
        r += DP[i][j][0b011] * (DP[i][j][0b100] + DP[i][j][0b101] + DP[i][j][0b110]);
    }
    writeln(r / 2);
}