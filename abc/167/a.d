import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto T = readln.chomp;
    writeln(T[0..S.length] == S ? "Yes" : "No");
}