import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long max_s = long.min;
    foreach (_; 0..N) {
        auto wh = readln.split.to!(long[]);
        max_s = max(max_s, wh[0] + wh[1]);
    }
    writeln(max_s);
}