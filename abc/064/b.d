import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    readln;
    auto as = readln.split.to!(int[]).sort().array;
    writeln(as[$-1] - as[0]);
}