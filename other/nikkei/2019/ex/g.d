import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto S = readln.chomp;
    int[26] cs;
    foreach (c; S) ++cs[c - 'a'];
    long o;
    foreach (c; cs) if (c%2 == 1) ++o;
    writeln(o == 0 ? S.length^^2 : (S.length - o + 1)^^2 + o - 1);
}