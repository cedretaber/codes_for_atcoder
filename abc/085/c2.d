import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ny = readln.split.to!(int[]);
    auto N = ny[0];
    auto Y = ny[1] / 1000;
    foreach (x; 0..N+1) {
        foreach (y; 0..N+1) {
            auto z = N - x - y;
            if (z < 0) break;
            if (10*x + 5*y + z == Y) {
                writefln("%d %d %d", x, y, z);
                return;
            }
        }
    }
    writeln("-1 -1 -1");
}