import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmk = readln.split.to!(int[]);
    auto N = nmk[0];
    auto K = nmk[1];
    auto M = nmk[2];
    int s;
    foreach (a; readln.split.to!(int[])) s += a;
    auto r = M*N - s;
    writeln(r > K ? -1 : max(0, r));
}