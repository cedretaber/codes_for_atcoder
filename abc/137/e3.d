import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias E = Tuple!(int, "from", int, "to", long, "c");

void main()
{
    auto nmp = readln.split.to!(int[]);
    auto N = nmp[0];
    auto M = nmp[1];
    long P = nmp[2];
    E[] es;
    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto A = abc[0]-1;
        auto B = abc[1]-1;
        long C = abc[2];
        es ~= E(A, B, C - P);
    }

    auto DP = new long[](N);
    DP[] = long.min/3;
    DP[0] = 0;

    foreach (_; 0..N) {
        foreach (e; es) {
            if (DP[e.to] < DP[e.from] + e.c) {
                DP[e.to] = DP[e.from] + e.c;
            }
        }
    }

    auto x = DP[N-1];
    foreach (_; 0..N) {
        foreach (e; es) {
            if (DP[e.from] > long.min/4 && DP[e.to] < DP[e.from] + e.c) {
                DP[e.to] = long.max/3;
            }
        }
    }
    writeln(DP[N-1] > x ? -1 : max(0, x));
}