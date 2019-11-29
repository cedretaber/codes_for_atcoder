import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);

    int r;
    foreach (i; 1..N-1) {
        int[char] CNT;
        foreach (c; S[0..i]) {
            CNT[c] = 1;
        }
        foreach (c; S[i..N]) {
            if (c in CNT) ++CNT[c];
        }
        int rr;
        foreach (_, v; CNT) if (v > 1) ++rr;
        r = max(r, rr);
    }
    writeln(r);
}