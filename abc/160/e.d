import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xyabc = readln.split.to!(int[]);
    auto X = xyabc[0];
    auto Y = xyabc[1];
    auto A = xyabc[2];
    auto B = xyabc[3];
    auto C = xyabc[4];
    auto ps = readln.split.to!(long[]);
    sort!"a > b"(ps);
    auto qs = readln.split.to!(long[]);
    sort!"a > b"(qs);
    auto rs = readln.split.to!(long[]);
    sort!"a > b"(rs);

    long res;
    foreach (i; 0..X) res += ps[i];
    foreach (i; 0..Y) res += qs[i];
    foreach (i; 0..C) res += rs[i];

    int i = X-1, j = Y-1, k = C-1;
    foreach (_; 0..C) {
        auto p = i >= 0 ? ps[i] : long.max;
        auto q = j >= 0 ? qs[j] : long.max;
        auto r = k >= 0 ? rs[k] : long.max;
        if (p <= q && p <= r) {
            --i;
            res -= p;
        } else if (q <= p && q <= r) {
            --j;
            res -= q;
        } else {
            --k;
            res -= r;
        }
    }
    writeln(res);
}