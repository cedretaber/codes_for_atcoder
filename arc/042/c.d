import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias O = Tuple!(int, "a", int, "b");

void main()
{
    auto np = readln.split.to!(int[]);
    auto N = np[0];
    auto P = np[1];
    O[] os;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        os ~= O(ab[0], ab[1]);
    }
    sort!"a.a < b.a"(os);
    auto DP = new int[][](N+1, P+101);
    foreach_reverse (i; 0..N) {
        foreach (j; 0..P+101) {
            DP[i][j] = DP[i+1][j];
            if (j - os[i].a >= 0) DP[i][j] = max(DP[i][j], DP[i+1][j-os[i].a] + os[i].b);
        }
    }
    int r;
    foreach (i; 0..N) {
        foreach (j; 0..P+os[i].a+1) {
            r = max(r, DP[i][j]);
        }
    }
    writeln(r);
}