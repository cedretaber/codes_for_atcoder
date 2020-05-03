import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    auto cs = new long[](N);
    foreach (long i; 0..N) {
        auto a = as[i];
        if (i - (a-1) < 0) continue;
        ++cs[i-(a-1)];
    }
    long r;
    foreach (ii, a; as) {
        auto i = ii.to!long;
        if (i + a + 1 >= N) continue;
        r += cs[i+a+1];
    }
    writeln(r);
}