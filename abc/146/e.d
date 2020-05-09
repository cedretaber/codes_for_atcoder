import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    long[] as;
    foreach (i, a; readln.split) {
        as ~= a.to!long;
        if (i) as[i] += as[i-1];
    }
    long[long] cs;
    cs[0] = 1;
    long r;
    foreach (i, a; as) {
        if (i >= K-1) {
            if (i-K == -1) {
                --cs[0];
            } else {
                auto k = (as[i-K] - (i.to!long-K) - 1) % K;
                --cs[k];
            }
        }
        auto j = (a - i.to!long - 1) % K;
        if (j in cs) r += cs[j];
        ++cs[j];
    }
    writeln(r);
}