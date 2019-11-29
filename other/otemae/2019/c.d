import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5+1] AS, BS;

void main()
{
    auto N = readln.chomp.to!int;
    auto A = readln.split.to!(int[]);
    foreach (b; readln.split.to!(int[])) ++BS[b];

    auto a = A[0];
    ++AS[a];
    auto r = BS[a];
    writeln(r);
    foreach (i; 1..N) {
        a = A[i];
        r = min(r, BS[a] / ++AS[a]);
        writeln(r);
    }
}