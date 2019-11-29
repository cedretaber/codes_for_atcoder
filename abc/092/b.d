import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    auto dx = readln.split.to!(int[]);
    auto D = dx[0];
    auto X = dx[1];
    int[] AS;
    AS.length = N;
    foreach (i; 0..N) AS[i] = readln.chomp.to!int;
    foreach (d; 0..D) {
        foreach (a; AS) if (d%a == 0) ++X;
    }
    writeln(X);
}