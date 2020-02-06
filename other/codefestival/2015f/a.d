import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.split;
    writeln(s[0].length == 5 && s[1].length == 7 && s[2].length == 5 ? "valid" : "invalid");
}