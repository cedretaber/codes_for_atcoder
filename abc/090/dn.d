import std.stdio, std.algorithm, std.conv, std.array, std.range, std.string, std.math, std.typecons;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    long cnt;
    for (long i; i <= N; ++i) {
        if (i < K) continue;
        cnt += N - i;
        foreach (j; 1..i) if (i % j >= K) ++cnt;
    }
    writeln(cnt);
}