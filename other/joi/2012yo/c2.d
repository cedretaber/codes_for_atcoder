import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    auto C = readln.chomp.to!int;
    int[] DS;
    foreach (_; 0..N) DS ~= readln.chomp.to!int;
    sort!"a > b"(DS);
    int r;
    foreach (i, d; DS) {
        C += d;
        r = max(r, C / (A + B*(i.to!int+1)));
    }
    writeln(r);
}