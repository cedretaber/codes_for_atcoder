import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    long r = long.max;
    for (long i = 1; i^^2 <= N; ++i) {
        if (N%i != 0) continue;
        r = min(r, i-1 + N/i-1);
    }
    writeln(r);
}