import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto abc = readln.split.to!(int[]).uniq.array;
    writeln(abc.length == 1 ? "Yes" : "No");
}