import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        G[A] ~= B;
        G[B] ~= A;
    }

    int r;
    auto memo = new bool[](N);
    void walk(int i, int[] as, int[] bs, int[] cs) {
        int nbs = [];
    }
}