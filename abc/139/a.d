import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    auto T = readln.chomp.to!(char[]);
    int r;
    foreach (i; 0..3) if (S[i] == T[i]) ++r;
    writeln(r);
}