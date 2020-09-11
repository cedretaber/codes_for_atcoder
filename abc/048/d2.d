import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto S = readln.chomp;
    writeln((S[0] == S[$-1] && S.length%2 == 0) || (S[0] != S[$-1] && S.length%2 == 1) ? "First" : "Second");
}