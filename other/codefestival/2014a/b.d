import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] abc;
    int s;
    foreach (_; 0..3) {
        auto n = readln.chomp.to!int;
        abc ~= n;
        s += n;
    }
    sort(abc);
    auto r = N/s * 3;
    auto d = N%s;
    foreach_reverse (n; abc) if (d > 0) {
        ++r;
        d -= n;
    }
    writeln(r);
}