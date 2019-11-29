import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = new int[](10^^6+1);
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto st = readln.split.to!(int[]);
        ++T[st[0]];
        --T[st[1]];
    }
    int c, r;
    foreach (t; T) {
        auto cc = c + t;
        if (c == 0 && cc != 0) ++r;
        c = cc;
    }
    writeln(r);
}