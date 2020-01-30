import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int c;
    foreach (_; 0..N-1) {
        auto st = readln.split.to!(int[]);
        if (st[0] == 1) ++c;
    }
    writeln(c == 1 || N%2 == 0 ? "A" : "B");
}