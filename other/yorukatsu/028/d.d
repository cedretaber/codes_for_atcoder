import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(long[]);
    auto N = nx[0];
    auto x = nx[1];
    auto as = readln.split.to!(long[]);
    long r;
    if (as[0] > x) {
        r += as[0] - x;
        as[0] = x;
    }
    foreach (i; 1..N) {
        auto s = as[i-1] + as[i];
        if (s > x) {
            r += s - x;
            as[i] -= s - x;
        }
    }
    writeln(r);
}