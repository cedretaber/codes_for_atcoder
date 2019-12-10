import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    auto as = readln.split.to!(int[]);
    sort(as);
    writeln(as.to!(string[]).join(" "));
}