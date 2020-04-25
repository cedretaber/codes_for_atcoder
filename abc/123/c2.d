import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    long n = long.max;
    foreach (_; 0..5) n = min(n, readln.chomp.to!long);
    writeln((N + n - 1) / n + 4);
}