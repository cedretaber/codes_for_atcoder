import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

long[2][10][2^^10] DP;
int[26] CI;
long[10] PS;

void main()
{
    auto nmyz = readln.split.to!(int[]);
    auto N = nmyz[0];
    auto M = nmyz[1];
    long Y = nmyz[2];
    long Z = nmyz[3];

    foreach (i; 0..M) {
        auto cp = readln.split;
        auto c = cp[0][0] - 'A';
        auto p = cp[1].to!long;
        CI[c] = i;
        PS[i] = p;
    }

    auto BS = readln.chomp.to!(char[]);

    foreach (m; 0..M) foreach (s; 0..(1<<M)) foreach (c; [0, 1]) {
        DP[s][m][c] = long.min / 3;
    }
    foreach (m; 0..(1<<M)) DP[0][m][0] = 0;

    foreach (i; 0..N) {
        auto cur = i%2;
        auto nxt = 1 - i%2;

        foreach (m; 0..M) foreach (s; 0..(1<<M)) {
            DP[s][m][nxt] = DP[s][m][cur];
        }

        auto x = CI[BS[i] - 'A'];
        foreach (m; 0..M) foreach (s; 0..(1<<M)) {
            DP[s|(1<<x)][x][nxt] = max(
                DP[s|(1<<x)][x][nxt],
                DP[s][m][cur] + PS[x] + (i > 0 && m == x && (s&(1<<x)) ? Y : 0)
            );
        }
    }

    auto r = long.min / 3;
    foreach (m; 0..M) foreach (s; 0..(1<<M)) {
        r = max(r, DP[s][m][N%2] + (s == (1<<M)-1 ? Z : 0));
    }
    writeln(r);
}