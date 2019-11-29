import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    int all = 1, odd = 1;
    foreach (a; AS) {
        int x, y;
        foreach (i; a-1..a+2) {
            ++x;
            if (i&1) ++y;
        }
        all *= x;
        odd *= y;
    }
    writeln(all - odd);
}