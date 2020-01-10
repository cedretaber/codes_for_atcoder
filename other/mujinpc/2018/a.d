import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto S = readln.chomp;
    writeln(S.length > 4 && S[0..5] == "MUJIN" ? "Yes" : "No");
}