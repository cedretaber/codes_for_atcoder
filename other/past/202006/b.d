import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmq = readln.split.to!(int[]);
    auto N = nmq[0];
    auto M = nmq[1];
    auto Q = nmq[2];

    auto ss = new bool[][](N, M);
    auto qs = new int[](M);
    foreach (_; 0..Q) {
        auto q = readln.split.to!(int[]);
        if (q[0] == 1) {
            auto n = q[1] - 1;
            int r;
            foreach (m; 0..M) if (ss[n][m]) r += N - qs[m];
            writeln(r);
        } else {
            auto n = q[1] - 1;
            auto m = q[2] - 1;
            qs[m] += 1;
            ss[n][m] = true;
        }
    }
}