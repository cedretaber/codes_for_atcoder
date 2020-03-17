import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    as = [0L] ~ as;
    foreach (i; 0..N) as[i+1] += as[i];
    foreach (k; 1..N+1) {
        long x;
        foreach (i; k..N+1) x = max(x, as[i] - as[i-k]);
        writeln(x);
    }
}