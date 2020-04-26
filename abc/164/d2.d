import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto DP = new long[](2019);
    DP[0] = 1;
    int n, d = 1;
    foreach_reverse (c; S) {
        n = ((c - '0').to!int * d + n) % 2019;
        (d *= 10) %= 2019;
        DP[n] += 1;
    }
    long r;
    foreach (x; DP) r += x * (x-1) / 2;
    writeln(r);
}