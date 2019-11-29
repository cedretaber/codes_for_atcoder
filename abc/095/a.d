import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    int X = 700;
    if (S[0] == 'o') X += 100;
    if (S[1] == 'o') X += 100;
    if (S[2] == 'o') X += 100;
    writeln(X);
}