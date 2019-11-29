import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!long;
    long[] rr;
    foreach (x; max(0, N-153)..N+1) {
        long s;
        auto d = x;
        while (d) {
            s += d % 10;
            d /= 10;
        }
        if (x + s == N) rr ~= x;
    }
    writeln(rr.length);
    foreach (r; rr) writeln(r);
}