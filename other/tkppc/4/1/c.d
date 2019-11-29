import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split;
    auto N = nx[0].to!long;
    auto X = nx[1];

    foreach (long m; 2..11) {
        long n;
        foreach (c; X) {
            n *= m;
            n += (c - '0');
        }
        if (n == N) {
            writeln(m);
            return;
        }
    }
}