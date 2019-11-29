import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto vs = readln.split.to!(int[]);
    auto cs = readln.split.to!(int[]);
    int r;
    foreach (i; 0..N) {
        if (vs[i] - cs[i] > 0) r += vs[i] - cs[i];
    }
    writeln(r);
}