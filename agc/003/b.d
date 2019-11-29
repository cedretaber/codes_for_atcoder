import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5] AS;

void main()
{
    auto N = readln.chomp.to!int;
    long r;
    foreach (i; 0..N) {
        auto A = readln.chomp.to!long;
        if (i != 0 && A > 0 && AS[i-1] > 0) {
            --A;
            ++r;
        }
        r += A/2;
        if (A%2 == 1) AS[i] = 1;
    }
    writeln(r);
}