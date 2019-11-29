import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    auto S = readln.chomp.to!(char[]);
    auto K = readln.chomp.to!int;
    auto c = S[K-1];
    foreach (ref s; S) if (s != c) s = '*';
    writeln(S);
}