import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto std = readln.split.to!(long[]);
    auto S = std[0];
    auto T = std[1];
    auto D = std[2];
    auto ws = readln.split.to!(long[]);

    long a;
    foreach (i, w; ws) {
        a += w;
        if (S + a <= T) {
            writeln(i+1);
            return;
        }
    }

    if (a > 0) {
        writeln(-1);
        return;
    }

    long s, min_r = ((S - T - a - 1) / -a) * D;
    foreach (i, w; ws) {
        s += w;
        if (s < 0) {
            auto x = (S - T + s - a - 1) / -a;
            min_r = min(min_r, x * D + i + 1);
        }
    }
    writeln(min_r);
}