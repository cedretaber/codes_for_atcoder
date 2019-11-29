import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5] AS, BS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(long[]);
        AS[i] = ab[0];
        BS[i] = ab[1];
    }

    long r;
    foreach_reverse (i; 0..N) {
        AS[i] += r;
        r += AS[i] % BS[i] == 0 ? 0 : BS[i] - AS[i] % BS[i];
    }
    writeln(r);
}