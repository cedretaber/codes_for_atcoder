import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ymd = readln.split.to!(int[]);
    writeln(ymd[1] == 12 && ymd[2] == 25 ? (ymd[0] - 2018).to!string : "NOT CHRISTMAS DAY");
}