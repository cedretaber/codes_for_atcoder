import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 100000;

void main()
{
    auto nms = readln.split.to!(int[]);
    auto N = nms[0];
    auto M = nms[1];
    auto S = nms[2];

    auto DP = new int[][][](2, M+2, S+1);
    DP[0][1][0] = 1;
    foreach (i; 0..N^^2) {
        foreach (j; 0..M+2) foreach (k; 0..S+1) DP[(i+1)%2][j][k] = 0;
        foreach (j; 1..M+1) {
            foreach (k; 0..S) {
                if (k+j <= S) DP[(i+1)%2][j+1][k+j] = DP[i%2][j][k];
                (DP[i%2][j+1][k] += DP[i%2][j][k]) %= P;
            }
        }
    }
    int s;
    foreach (j; 0..M+2) (s += DP[(N^^2)%2][j][S]) %= P;
    writeln(s);
}