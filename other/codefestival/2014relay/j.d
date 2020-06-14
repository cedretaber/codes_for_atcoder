import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    if (K == 0) {
        writeln(N%2 == 1 ? "first" : "second");
        return;
    }

    auto n = 3 + 2 * (K-1);
    if (N <= n) {
        writeln("first");
    } else {
        N -= n;
        writeln(N%2 == 0 ? "first" : "second");
    }
}