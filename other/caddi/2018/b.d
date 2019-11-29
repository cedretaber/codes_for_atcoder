import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nhw = readln.split.to!(int[]);
    auto N = nhw[0];
    auto H = nhw[1];
    auto W = nhw[2];

    int r;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        if (ab[0] >= H && ab[1] >= W) ++r;
    }
    writeln(r);
}