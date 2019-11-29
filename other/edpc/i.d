import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto PS = readln.split.to!(double[]);

    double[][] MEMO;
    MEMO.length = N;
    foreach (ref m; MEMO) m.length = N+1;

    double zero = 0.0, one = 1.0;

    foreach (i; 0..N) {
        if (!i) {
            MEMO[i][0] = one - PS[i];
            MEMO[i][1] = PS[i];
            continue;
        }
        foreach (j; 0..i+2) {
            MEMO[i][j] = (MEMO[i-1][j].isNaN ? zero : MEMO[i-1][j] * (one - PS[i])) + (j ? MEMO[i-1][j-1] * PS[i] : zero);
        }
    }

    double ret = 0.0;
    foreach (c; N/2+1..N+1) {
        ret += MEMO[N-1][c];
    }
    writefln("%1.10f", ret);
}