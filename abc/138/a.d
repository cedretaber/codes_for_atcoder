import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto a = readln.chomp.to!int;
    auto s = readln.chomp;
    writeln(a >= 3200 ? s : "red");
}