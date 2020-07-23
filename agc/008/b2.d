import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto as = readln.split.to!(long[]);

    auto cs = new long[](N);
    foreach (i, a; as) {
        if (i) cs[i] = cs[i-1];
        if (a > 0) cs[i] += a;
    }

    long max_r, sum_a;
    foreach (a; as[0..K]) sum_a += a;
    max_r = max(0, sum_a) + cs[$-1] - cs[K-1];
    foreach (i, a; as[K..$]) {
        sum_a += -as[i] + a;
        auto c = cs[$-1] + cs[i] - cs[i+K];
        max_r = max(max_r, c, sum_a + c);
    }
    writeln(max_r);
}