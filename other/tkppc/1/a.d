import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        writeln(ab[0] + ab[1]);
    }
}