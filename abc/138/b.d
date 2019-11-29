import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(double[]);
    double dp = 0;
    foreach (i; 0..N) {
        dp += 1.0 / AS[i];
    }
    writefln("%.10f", 1.0 / dp);
}