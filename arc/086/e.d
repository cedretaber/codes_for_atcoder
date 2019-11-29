import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int[(10^^5)*2][] PS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 1..N+1) {
        auto p = readln.chomp.to!int;
        PS[i] ~= p;
    }
}