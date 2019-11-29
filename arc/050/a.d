import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto c = readln.chomp;
    writeln(c[0]+32 == c[2] ? "Yes" : "No");
}