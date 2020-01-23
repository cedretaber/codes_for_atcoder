import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    auto C = readln.chomp.to!int;
    auto D = readln.chomp.to!int;
    auto E = readln.chomp.to!int;
    auto F = readln.chomp.to!int;

    auto ps = [A, B, C, D];
    sort(ps);
    ps = ps[1..$];
    int s;
    foreach (p; ps) s += p;
    writeln(s + max(E, F));
}