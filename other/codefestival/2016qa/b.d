import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = [0] ~ readln.split.to!(int[]);
    int r;
    foreach (i; 1..N+1) {
        if (as[as[i]] == i) ++r;
    }
    writeln(r/2);
}