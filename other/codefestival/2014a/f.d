import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto G = new int[][N];
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        G[B] ~= A;
    }
    auto F = new bool[N];
    void run(int i) {
        F[i] = true;
        foreach (j; G[i]) if (!F[j]) run(j);
    }
    run(0);
    int c;
    foreach (f; F) if (f) ++c;
    writeln(c);
}