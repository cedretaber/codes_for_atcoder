import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5] AS;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    auto x = as[0];
    foreach (a; as) {
        x = gcd(x, a);
    }
    writeln(x);
}