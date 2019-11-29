import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto ab = readln.split.to!(double[]);
    auto A = ab[0];
    auto B = ab[1];
    if (A > B) swap(A, B);
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto cd = readln.split.to!(double[]);
        auto C = cd[0];
        auto D = cd[1];
        if (C > D) swap(C, D);
        if (C >= A && D >= B) {
            writeln("YES");
            continue;
        }
        if (C < A) {
            writeln("NO");
            continue;
        }
        double min_r = 0, max_r = 90;
        double calc(double r) {
            auto t = r * PI / 180;
            return cos(t) * A + sin(t) * B;
        }
        while (abs(calc(max_r) - C) >= 0.01) {
            auto mid_r = (max_r + min_r) / 2;
            if (calc(mid_r) > C) {
                max_r = mid_r;
            } else {
                min_r = mid_r;
            }
        }
        auto t = max_r * PI / 180;
        if (sin(t) * A + cos(t) * B <= D) {
            writeln("YES");
        } else {
            writeln("NO");
        }
    }
}