import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    writeln(S.length > 3 && S[0..4] == "YAKI" ? "Yes" : "No");
}