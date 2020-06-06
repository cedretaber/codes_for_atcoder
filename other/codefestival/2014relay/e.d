import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto H = readln.split[0].to!int;
    int r;
    foreach (_; 0..H) foreach (c; readln.chomp) if (c != '.') r += (c - '0').to!int;
    writeln(r);
}