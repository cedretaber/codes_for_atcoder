import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    int r;
    foreach (h; readln.split.to!(int[])) if (h >= K) ++r;
    writeln(r);
}