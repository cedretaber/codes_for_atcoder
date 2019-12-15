import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    long x;
    foreach (i, a; as) {
        long l, r;
        foreach (b; as[0..i]) if (a > b) ++l;
        if (i != N-1) foreach (b; as[i+1..$]) if (a > b) ++r;
        x += l * r;
    }
    writeln(x);
}