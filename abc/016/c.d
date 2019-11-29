import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

bool[11][11] MEMO;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        MEMO[ab[0]][ab[1]] = true;
        MEMO[ab[1]][ab[0]] = true;
    }

    foreach (i; 1..N+1) {
        bool[int] not = [i: true];
        int[] fs;
        foreach (j; 0..N+1) if (MEMO[i][j]) {
            fs ~= j;
            not[j] = true;
        }
        bool[int] ffs;
        foreach (f; fs) foreach (j; 1..N+1) if (MEMO[f][j]) ffs[j] = true;
        int r;
        foreach (j, _; ffs) if (j !in not) ++r;
        writeln(r);
    }
}