import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abq = readln.split.to!(int[]);
    auto A = abq[0];
    auto B = abq[1];
    auto Q = abq[2];
    long[] ss = [long.min/5], ts = [long.min/5];
    foreach (_; 0..A) ss ~= readln.chomp.to!long;
    foreach (_; 0..B) ts ~= readln.chomp.to!long;
    ss ~= long.max/5;
    ts ~= long.max/5;

    foreach (_; 0..Q) {
        auto x = readln.chomp.to!long;
        int l, r = A+1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (ss[m] <= x) {
                l = m;
            } else {
                r = m;
            }
        }
        auto al = ss[l], ar = ss[r];
        l = 0, r = B+1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (ts[m] <= x) {
                l = m;
            } else {
                r = m;
            }
        }
        auto bl = ts[l], br = ts[r];
        writeln(min(
            max(x - al, x - bl),
            max(ar - x, br - x),
            (x - al) * 2 + br - x,
            (x - bl) * 2 + ar - x,
            (ar - x) * 2 + x - bl,
            (br - x) * 2 + x - al
        ));
    }
}