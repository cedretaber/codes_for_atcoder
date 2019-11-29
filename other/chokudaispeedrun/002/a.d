import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto wh = readln.split.to!(long[]);
        writeln(wh[0] * wh[1]);
    }
}