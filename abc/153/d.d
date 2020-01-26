import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto H = readln.chomp.to!long;
    long d, x = 1;
    while (H) {
        d += x;
        x *= 2;
        H /= 2;
    }
    writeln(d);
}