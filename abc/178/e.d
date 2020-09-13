import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    int N = readln.chomp.to!int;
    long[] xs, ys;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(long[]);
        xs ~= xy[0];
        ys ~= xy[1];
    }
    long max_a = long.min, min_a = long.max, max_b = long.min, min_b = long.max;
    foreach (i; 0..N) {
        auto a = xs[i] - ys[i];
        max_a = max(max_a, a);
        min_a = min(min_a, a);

        auto b = xs[i] + ys[i];
        max_b = max(max_b, b);
        min_b = min(min_b, b);
    }
    writeln(max(max_a - min_a, max_b - min_b));
}