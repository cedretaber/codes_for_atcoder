import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    AS = [0] ~ AS ~ 0;
    int s;
    foreach (i; 0..N+1) s += abs(AS[i] - AS[i+1]);
    foreach (i; 1..N+1) {
        writeln(s - abs(AS[i-1] - AS[i]) - abs(AS[i] - AS[i+1]) + abs(AS[i-1] - AS[i+1]));
    }
}