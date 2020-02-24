import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    long r;
    foreach (n; K+1..N+1) {
        r += N/n * (n-K);
        r += max(0, N - N/n * n - max(0, K-1));
    }
    writeln(r);
}