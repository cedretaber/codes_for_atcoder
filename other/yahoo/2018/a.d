import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto S = readln.to!(wchar[]);
    writeln(S[0..3] == "yah" && S[3] == S[4] ? "YES" : "NO");
}