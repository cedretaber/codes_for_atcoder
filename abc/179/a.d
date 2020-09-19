import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto S = readln.chomp;
    writeln(S[$-1] == 's' ? S ~ "es" : S ~ "s");
}