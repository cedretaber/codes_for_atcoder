import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto lr = readln.split.to!(long[]);
    auto L = lr[0];
    auto R = lr[1];
    if (R - L >= 2050) {
        writeln(0);
    } else {
        long min_r = long.max;
        foreach (i; L..R) foreach (j; i+1..R+1) min_r = min(min_r, i * j % 2019L);
        writeln(min_r);
    }
}