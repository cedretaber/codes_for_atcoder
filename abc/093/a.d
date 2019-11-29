import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto S = readln.chomp.to!(dchar[]);
    sort(S);
    writeln(S == "abc" ? "Yes" : "No");
}