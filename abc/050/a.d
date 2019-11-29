import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto line = readln.split;
    auto a = line[0].to!long;
    auto b = line[2].to!long;

    writeln(line[1] == "+" ? a + b : a - b);
}