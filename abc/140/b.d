import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);
    auto CS = readln.split.to!(int[]);

    int r;
    foreach (i; 0..N) {
        auto x = AS[i] - 1;
        r += BS[x];
        if (i < N-1 && AS[i+1] == x+2) r += CS[x];
    }
    writeln(r);
}