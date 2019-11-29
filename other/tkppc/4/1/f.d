import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    long[][] AS, BS;
    AS.length = N;
    foreach (i; 0..N) AS[i] = readln.split.to!(long[]);
    BS.length = M;
    foreach (j; 0..M) BS[j] = readln.split.to!(long[]);

    long r;
    foreach (i; 0..N) {
        long s = long.max;
        foreach (j; 0..M) {
            auto x = r / AS[i][j] * AS[i][j];
            if (x < r) x += AS[i][j];
            s = min(s, x + BS[i][j] - r);
        }
        r += s;
    }
    writeln(r);
}