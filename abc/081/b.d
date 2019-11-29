import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);

    auto cnt = int.max;
    foreach (a; AS) {
        int i;
        for (; a && a%2 == 0; ++i) a /= 2;
        cnt = min(cnt, i);
    }
    writeln(cnt);
}