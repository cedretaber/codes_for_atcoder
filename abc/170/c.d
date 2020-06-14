import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xn = readln.split.to!(int[]);
    auto X = xn[0];
    auto N = xn[1];
    bool[101] ps;
    foreach (p; readln.split.to!(int[])) ps[p] = true;
    foreach (d; 0..100) {
        auto x = X-d;
        if (x < 0 || !ps[x]) {
            writeln(x);
            return;
        }
        auto y = X+d;
        if (y > 100 || !ps[y]) {
            writeln(y);
            return;
        }
    }
}