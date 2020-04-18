import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    auto as = readln.split.to!(long[]);
    auto x = as[0];
    foreach (a; as[1..$]) x = gcd(a, x);
    writeln(x);
}