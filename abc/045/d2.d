import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(long, "a", long, "b");

void main()
{
    auto hwn = readln.split.to!(long[]);
    auto H = hwn[0];
    auto W = hwn[1];
    auto N = hwn[2];

    int[P] ps;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0];
        auto b = ab[1];
        foreach (j; a-1..a+2) {
            foreach (k; b-1..b+2) {
                if (1 < j && j < H && 1 < k && k < W) {
                    ++ps[P(j, k)];
                }
            }
        }
    }
    long[10] rs;
    long x;
    foreach (_, n; ps) {
        ++x;
        ++rs[n];
    }
    rs[0] = (H-2) * (W-2) - x;
    foreach (r; rs) writeln(r);
}