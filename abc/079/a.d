import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!(wchar[]);
    writeln(N[1] != N[2] ? "No" : N[0] == N[1] || N[2] == N[3] ? "Yes" : "No");

}