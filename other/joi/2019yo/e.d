import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias LR = Tuple!(int, "l", int, "r");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto AS = readln.split.to!(long[]);
    auto lrs = new LR[](M);
    foreach (i; 0..M) {
        auto lr = readln.split.to!(int[]);
        lrs[i] = LR(lr[0], lr[1]);
    }
    sort!"a.l < b.l"(lrs);
    auto rs = new int[](N);
    int j, max_r;
    foreach (i; 0..N) {
        while (j < M && lrs[j].l-1 <= i) max_r = max(max_r, lrs[j++].r);
        max_r = max(i+1, max_r);
        rs[i] = max_r;
    }
    auto DP = new long[](N);
    DP[] = -1;
    long solve(int i) {
        if (i == N) return 0;
        if (DP[i] == -1) DP[i] = max(solve(i+1), solve(rs[i]) + AS[i]);
        return DP[i];
    }
    writeln(solve(0));
}