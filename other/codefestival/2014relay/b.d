import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto as = readln.split.to!(int[]);
    writeln(as[0] >= as[1] ? "Congratulations!" : "Enjoy another semester...");
}