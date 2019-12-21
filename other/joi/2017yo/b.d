import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto cs = new int[](M);
    foreach (i; 0..M) {
        cs[i] = readln.split.to!(int[])[0];
    }
    sort!"a > b"(cs);
    int r;
    foreach (a; cs[0..$-1]) r += N - min(N, a);
    writeln(r);
}