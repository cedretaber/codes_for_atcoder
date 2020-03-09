import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    int c;
    foreach (a; AS) {
        while (a && a%2 == 0) {
            ++c;
            a /= 2;
        }
    }
    writeln(c);
}