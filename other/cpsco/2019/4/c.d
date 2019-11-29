import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    auto D = nd[1];
    auto RS = readln.split.to!(int[]);
    sort(RS);
    int j = 1;
    long r;
    foreach (i; 0..N) {
        while (j < N && RS[j] - RS[i] <= D) ++j;
        auto d = max(0, j - i - 2).to!long;
        r += d * (d+1) / 2;
    }
    writeln(r);
}