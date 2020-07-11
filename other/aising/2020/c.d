import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto rs = new int[](10^^4+1);
    foreach (x; 1..101) foreach (y; 1..101) foreach (z; 1..101) {
        auto n = x^^2 + y^^2 + z^^2 + x*y + y*z + z*x;
        if (n > 10^^4) continue;
        ++rs[n];
    }
    auto N = readln.chomp.to!int;
    foreach (i; 1..N+1) writeln(rs[i]);
}