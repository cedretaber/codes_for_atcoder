import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto AS = readln.split.to!(long[]);

    long r = 1;
    foreach (i, a; AS) {
        if (i < K) continue;
        writeln(a > AS[i-K] ? "Yes" : "No");
    }
}