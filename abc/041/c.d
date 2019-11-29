import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias A = Tuple!(int, "i", int, "t");

A[10^^5] AS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (int i, a; readln.split.to!(int[])) {
        AS[i] = A(i, a);
    }
    sort!"a.t > b.t"(AS[0..N]);
    foreach (a; AS[0..N]) writeln(a.i + 1);
}