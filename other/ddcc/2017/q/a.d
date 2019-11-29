import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    writeln(S[0] == S[1] && S[1] != S[2] && S[2] == S[3] ? "Yes" : "No");
}