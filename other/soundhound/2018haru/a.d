import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

void main()
{
    auto ws = readln.split.to!(wchar[][]);
    writeln([ws[0][0],ws[1][0]] == "SH" ? "YES" : "NO");
}