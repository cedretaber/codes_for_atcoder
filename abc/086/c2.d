import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long[] ts, xs, ys;
    foreach (_; 0..N) {
        auto txy = readln.split.to!(long[]);
        ts ~= txy[0];
        xs ~= txy[1];
        ys ~= txy[2];
    }

    long t, x, y;
    foreach (i; 0..N) {
        auto d = ts[i] - t;
        auto dd = abs(xs[i]-x) + abs(ys[i]-y);
        if (dd > d || (d-dd)%2 != 0) {
            writeln("No");
            return;
        }
        t = ts[i];
        x = xs[i];
        y = ys[i];
    }
    writeln("Yes");
}