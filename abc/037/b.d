import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    auto ns = new int[](N);
    foreach (_; 0..Q) {
        auto lrt = readln.split.to!(int[]);
        auto L = lrt[0];
        auto R = lrt[1];
        auto T = lrt[2];
        foreach (i; L-1..R) ns[i] = T;
    }
    foreach (n; ns) writeln(n);
}