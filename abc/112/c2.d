import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] xs, ys;
    long[] hs;
    foreach (_; 0..N) {
        auto xyh = readln.split.to!(int[]);
        xs ~= xyh[0];
        ys ~= xyh[1];
        hs ~= xyh[2];
    }
    foreach (y; 0..101) {
        foreach (x; 0..101) {
            long h;
            foreach (i; 0..N) {
                if (hs[i] != 0) {
                    h = hs[i] + abs(x - xs[i]) + abs(y - ys[i]);
                    break;
                }
            }
            foreach (i; 0..N) {
                if (hs[i] != max(0, h - abs(x - xs[i]) - abs(y - ys[i]))) goto ng;
            }
            writeln(x, " ", y, " ", h);
            ng:
        }
    }
}