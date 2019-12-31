import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long x = 1;
    long s = 1;
    while (N) {
        --N;
        x *= 5;
        s += x;
    }
    writeln(s);
}