import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    foreach (_; 0..Q) {
        auto abst = readln.split.to!(int[]);
        auto a = abst[0];
        auto b = abst[1];
        auto s = abst[2];
        auto t = abst[3];

        if (a >= t || b <= s) {
            writeln((t - s) * 100);
        } else if (a <= s && b <= t) {
            writeln((t - b) * 100);
        } else if (s <= a && t <= b) {
            writeln((a - s) * 100);
        } else if (s <= a && b <= t) {
            writeln((t - s - (b - a)) * 100);
        } else {
            writeln(0);
        }
    }
}