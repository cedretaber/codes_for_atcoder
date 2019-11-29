import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ta = readln.split.to!(double[]);
    auto T = ta[0];
    auto A = ta[1];
    auto HS = readln.split.to!(double[]);

    double min_t = double.max;
    int idx;
    foreach (int i, h; HS) {
        auto t = abs(A - (T - h * 0.006));
        if (t < min_t) {
            min_t = t;
            idx = i;
        }
    }
    writeln(idx + 1);
}