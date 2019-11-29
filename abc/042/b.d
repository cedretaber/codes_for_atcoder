import std.stdio, std.string, std.conv, std.array, std.algorithm, std.range;

void main()
{
    auto n = readln.chomp.split(" ").map!(to!int)[0];
    string[] lines;
    0.iota(n).each!(_a => lines ~= readln.chomp);
    writeln(lines.sort!"a<b".join(""));
}