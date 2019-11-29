import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int c;
    foreach (i; 1..N+1) {
        if (i < 10 || (100 <= i && i < 1000) || (10000 <= i && i < 100000)) ++c;
    }
    writeln(c);
}