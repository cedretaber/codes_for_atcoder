import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmr = readln.split.to!(int[]);
    auto N = nmr[0];
    auto M = nmr[1];
    auto R = nmr[2];
    auto rs = readln.split.to!(int[]).map!"a - 1"().array();
    sort(rs);
    auto MAP = new long[][](N, N);
    foreach (ref map; MAP) map[] = long.max/3;
    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto A = abc[0]-1;
        auto B = abc[1]-1;
        long C = abc[2];
        MAP[A][B] = C;
        MAP[B][A] = C;
    }

    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) if (MAP[i][j] > MAP[i][k] + MAP[k][j]) MAP[i][j] = MAP[i][k] + MAP[k][j];

    long res = long.max;
    do {
        long rr;
        foreach (i; 1..R) rr += MAP[rs[i-1]][rs[i]];
        res = min(res, rr);
    } while (nextPermutation(rs));

    writeln(res);
}