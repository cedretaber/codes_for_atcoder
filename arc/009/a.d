import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    int r;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        r += ab[0] * ab[1];
    }
    writeln((r * 1.05).to!int);
}