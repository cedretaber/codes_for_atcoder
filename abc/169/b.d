import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    foreach (a; AS) if (a == 0) {
        writeln(0);
        return;
    }
    long r = 1;
    foreach (a; AS) {
        if (r * a < r || r * a > 10L^^18) {
            writeln(-1);
            return;
        }
        r *= a;
    }
    writeln(r);
}