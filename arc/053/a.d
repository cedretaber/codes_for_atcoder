import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    long c;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (i+1 < H) ++c;
            if (j+1 < W) ++c;
        }
    }
    writeln(c);
}