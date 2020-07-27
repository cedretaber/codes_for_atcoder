import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    int S;
    auto cs = new int[](M+1);
    foreach (_; 0..N) {
        auto lrs = readln.split.to!(int[]);
        auto l = lrs[0]-1;
        auto r = lrs[1];
        auto s = lrs[2];
        cs[l] += s;
        cs[r] -= s;
        S += s;
    }
    foreach (i; 0..M) cs[i+1] += cs[i];
    int s;
    foreach (i; 0..M) s = max(s, S - cs[i]);
    writeln(s);
}