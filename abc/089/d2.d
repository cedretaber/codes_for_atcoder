import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias A = Tuple!(int, "i", int, "j");

A[300*300+1] AS;
long[300*300+1] DS;

void main()
{
    auto hwd = readln.split.to!(int[]);
    auto H = hwd[0];
    auto W = hwd[1];
    auto D = hwd[2];

    foreach (j; 0..H) 
        foreach(i, e; readln.split.to!(int[]))
            AS[e] = A(i.to!int, j);
    
    foreach (i; 1..D+1) {
        long d;
        DS[i] = d;
        while (i <= H*W-D) {
            auto a = AS[i];
            i += D;
            auto ad = AS[i];
            d += abs(a.i - ad.i) + abs(a.j - ad.j);
            DS[i] = d;
        }
    }

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto lr = readln.split.to!(int[]);
        auto L = lr[0];
        auto R = lr[1];

        writeln(DS[R] - DS[L]);
    }
}