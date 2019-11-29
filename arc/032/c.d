import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias T = Tuple!(int, "i", int, "a", int, "b");

T[10^^5] TS;
int[10^^6+1] DP;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (int i; 0..N) {
        auto ab = readln.split.to!(int[]);
        TS[i] = T(i, ab[0], ab[1]);
    }
    sort!"a.b == b.b ? a.i < b.i : a.b < b.b"(TS[0..N]);
}