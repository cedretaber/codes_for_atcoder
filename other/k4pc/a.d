import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int r;
    foreach (i; 1..N+1) {
        auto a = readln.chomp.to!int;
        r += abs(i - a);
    }
    writeln(r/2);
}