import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum CS = [500, 100, 50, 10, 5];

void main()
{
    auto N = 1000 - readln.chomp.to!int;
    int r;
    foreach (c; CS) {
        while (N >= c) {
            ++r;
            N -= c;
        }
    }
    writeln(r + N);
}