import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto S = readln.chomp;
    auto T = readln.chomp;
    int r = 1000;
    foreach (i; 0..S.length - T.length + 1) {
        int rr;
        foreach (j, t; T) if (S[i+j] != t) ++rr;
        r = min(r, rr);
    }
    writeln(r);
}