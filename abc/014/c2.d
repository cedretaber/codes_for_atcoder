import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto N = readln.chomp.to!int;
    auto cs = new int[](10^^6+2);
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        ++cs[ab[0]];
        --cs[ab[1]+1];
    }
    auto max_c = cs[0];
    foreach (i; 1..10^^6+2) {
        cs[i] += cs[i-1];
        max_c = max(max_c, cs[i]);
    }
    writeln(max_c);
}