import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias A = Tuple!(long, "i", long, "j");

void main()
{
    auto hwd = readln.split.to!(int[]);
    auto H = hwd[0];
    auto W = hwd[1];
    auto D = hwd[2];
    auto AS = new A[](H*W+1);
    foreach (long i; 0..H) {
        foreach (j, a; readln.split.to!(int[])) {
            AS[a] = A(i, j.to!long);
        }
    }
    auto BS = new long[](H*W+1);
    foreach (x; 1..D+1) {
        while (x+D <= H*W) {
            auto p = AS[x];
            auto q = AS[x+D];
            BS[x+D] = BS[x] + abs(p.i - q.i) + abs(p.j - q.j);
            x += D;
        }
    }
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto lr = readln.split.to!(int[]);
        writeln(BS[lr[1]] - BS[lr[0]]);
    }
}