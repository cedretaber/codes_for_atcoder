import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    long SUM;
    foreach (a; AS) SUM += a;
    long x;
    foreach (a; AS) {
        if (x + a >= SUM/2) {
            writeln(min((x+a)*2 - SUM, SUM - x*2));
            return;
        }
        x += a;
    }
}