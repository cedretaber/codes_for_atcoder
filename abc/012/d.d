import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[300][300] BS;

void main()
{
    foreach (ref bs; BS) foreach (ref b; bs) b = long.max / 3;
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..M) {
        auto abt = readln.split.to!(int[]);
        auto a = abt[0]-1;
        auto b = abt[1]-1;
        auto t = abt[2].to!long;
        BS[a][b] = t;
        BS[b][a] = t;
    }

    foreach (k; 0..N)
        foreach (i; 0..N)
            foreach (j; 0..N)
                if (BS[i][k] + BS[k][j] < BS[i][j])
                    BS[i][j] = BS[i][k] + BS[k][j];

    auto r = long.max;
    foreach (i; 0..N) {
        long rr;
        foreach (j; 0..N) if (i != j) rr = max(rr, BS[i][j]);
        r = min(r, rr);
    }
    writeln(r);
}