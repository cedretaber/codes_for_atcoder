import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nc = readln.split.to!(int[]);
    long N = nc[0];
    auto C = nc[1];
    auto as = readln.split.to!(long[]);

    auto ls = new long[](C+1);
    auto rs = new long[](C+1);
    foreach (i; 0..N) {
        auto a = as[i];
        rs[a] += (i+1) * (N-i) - ls[a] * (N-i);
        ls[a] = i+1;
    }
    foreach (r; rs[1..$]) writeln(r);
}