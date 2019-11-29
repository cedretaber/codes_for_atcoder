import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmc = readln.split.to!(int[]);
    auto N = nmc[0];
    auto M = nmc[1];
    auto C = nmc[2];

    auto bs = readln.split.to!(int[]);
    int cnt;
    foreach (_; 0..N) {
        int d;
        foreach (i, a; readln.split.to!(int[])) {
            auto b = bs[i];
            d += a * b;
        }
        if (d + C > 0) ++cnt;
    }
    writeln(cnt);
}