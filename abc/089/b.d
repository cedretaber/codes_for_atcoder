import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    readln;
    auto hs = readln.split;
    sort(hs);
    writeln(hs.uniq.count == 3 ? "Three" : "Four");
}