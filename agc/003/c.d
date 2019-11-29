import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5] AS;
int[int] RI;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto A = readln.chomp.to!int;
        AS[i] = A;
        RI[A] = i;
    }
    sort(AS[0..N]);
    int c;
    foreach (i; 0..N) {
        if (i%2 != RI[AS[i]]%2) ++c;
    }
    writeln(c/2);
}