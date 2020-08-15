import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    long[] xs;
    foreach (_; 0..M) xs ~= readln.chomp.to!long;

    if (N == M) {
        writeln(0);
        return;
    }

    long l, r = N*2;
    while (l+1 < r) {
        auto m = (l+r)/2;
        auto i = 1L;
        foreach (x; xs) {
            auto d = m;
            if (i < x) {
                d -= x-i;
                if (d < 0) goto ng;
                d = max(d/2, d-(x-i));
            }
            i = x + 1 + max(0, d);
        }
        if (i <= N) goto ng;
        r = m;
        continue;
        ng:
        l = m;
    }
    writeln(r);
}