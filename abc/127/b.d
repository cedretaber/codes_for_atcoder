import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rdx = readln.split.to!(long[]);
    auto r = rdx[0];
    auto D = rdx[1];
    auto x = rdx[2];
    foreach (_; 0..10) {
        x = r*x-D;
        writeln(x);
    }
}