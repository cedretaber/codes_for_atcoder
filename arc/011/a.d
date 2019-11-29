import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto mnn = readln.split.to!(int[]);
    auto m = mnn[0];
    auto n = mnn[1];
    auto N = mnn[2];

    int s, r;
    while (N) {
        s += N;
        N += r;
        r = N % m;
        N = N / m * n;
    }
    writeln(s);
}