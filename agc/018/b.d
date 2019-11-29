import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    int[][] AS;
    AS.length = N;
    foreach (ref A; AS) {
        A = readln.split.to!(int[]).map!"a-1".array;
    }

    auto ii = new int[](N);
    auto ms = new bool[](M);
    int r = int.max;
    foreach (_; 0..M) {
        auto cnt = new int[](M);
        foreach (i, ref j; ii) {
            while (ms[AS[i][j]]) {
                ++j;
            }
            ++cnt[AS[i][j]];
        }
        int jj, max_c;
        foreach (j, c; cnt) if (c > max_c) {
            max_c = c;
            jj = j.to!int;
        }
        r = min(r, max_c);
        ms[jj] = true;
    }
    writeln(r);
}