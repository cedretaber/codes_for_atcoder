import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    reverse(AS);
    long min_a = 2, max_a = 2;
    foreach (i, a; AS) {
        if ((min_a + a - 1) / a * a > max_a) {
            writeln(-1);
            return;
        }
        min_a = (min_a + a - 1) / a * a;
        max_a = max_a / a * a + a - 1;
    }
    writefln("%d %d", min_a, max_a);
}