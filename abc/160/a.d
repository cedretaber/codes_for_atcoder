import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    writeln(S[2] == S[3] && S[4] == S[5] ? "Yes" : "No");
}