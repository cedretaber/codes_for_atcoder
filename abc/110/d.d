import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;

int[2][] prime_division(int m)
{
    int[2][] r;
    for (int x = 2; x^^2 <= m; ++x) {
        int cnt;
        while (m % x == 0) {
            ++cnt;
            m /= x;
        }
        if (cnt) r ~= [x, cnt];
    }
    if (m != 1) r ~= [m, 1];
    return r;
}

void main()
{
    auto nm = readln.split.to!(int[]);
    long N = nm[0];
    auto M = nm[1];

    long[][] MEMO;
    MEMO.length = 10^^5+1;
    foreach_reverse (i, ref memo; MEMO[0..N+1]) {
        memo.length = 41;
        foreach (j, ref x; memo) {
            if (j == 0) {
                x = 1;
            } else if (i == N) {
                x = 0;
            } else {
                x = (MEMO[i+1][j] + MEMO[i][j-1]) % P;
            }
        }
    }

    long r = 1;
    foreach (p; prime_division(M)) {
        r = (r * MEMO[0][p[1]]) % P;
    }
    writeln(r);
}