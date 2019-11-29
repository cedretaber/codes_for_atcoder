import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    auto AS = readln.split.to!(int[]);
    sort!"a > b"(AS);
    auto x = AS[0];
    foreach (a; AS[1..$]) x = gcd(x, a);

    if (K > AS[0] || K%x != 0) {
        writeln("IMPOSSIBLE");
    } else {
        writeln("POSSIBLE");
    }
}