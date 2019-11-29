import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.to!(wchar[]);
    writeln(N[0] == '9' || N[1] == '9' ? "Yes" : "No");
}