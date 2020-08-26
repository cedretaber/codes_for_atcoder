import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

long P = 10^^9+7;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[] fs;
    foreach (_; 0..N) fs ~= readln.chomp.to!int-1;

    auto bs = new bool[](M);
    auto rs = new int[](N);
    {
        int i, j;
        while (i < N) {
            if (j == N || bs[fs[j]]) {
                rs[i] = j;
                bs[fs[i]] = false;
                ++i;
            } else {
                bs[fs[j]] = true;
                ++j;
            }
        }
    }
    auto cs = new long[](N+1);
    cs[0] = 1;
    long s = 1;
    foreach (i; 0..N) {
        (cs[rs[i]] += s) %= P;
        s = (s * 2 % P - cs[i] + P) % P;
    }
    writeln(s);
}