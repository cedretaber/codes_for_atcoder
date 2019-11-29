import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ds = readln.split.to!(int[]);
    sort(ds);
    auto M = readln.chomp.to!int;
    auto ts = readln.split.to!(int[]);
    sort(ts);
    size_t i, j;
    while (i < N && j < M) {
        if (ds[i] < ts[j]) {
            ++i;
        } else if (ds[i] == ts[j]) {
            ++i;
            ++j;
        } else {
            writeln("NO");
            return;
        }
    }
    writeln(j == M ? "YES" : "NO");
}