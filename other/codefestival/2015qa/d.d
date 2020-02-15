import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    long N = nm[0];
    auto M = nm[1];
    long[] XS;
    foreach (_; 0..M) XS ~= readln.chomp.to!long;

    if (N == M) {
        writeln(0);
        return;
    }

    long l, r = 10^^9*2;
    while (l+1 < r) {
        auto m = (l+r)/2;
        long pos = 1;
        foreach (i, x; XS) {
            auto d = m;
            if (pos < x) {
                d -= x-pos;
                if (d < 0) goto ng;
                d = max(d/2, d-(x-pos));
            }
            pos = x + 1 + max(0, d);
        }
        if (pos <= N) goto ng;
        r = m;
        continue;
        ng:
        l = m;
    }
    writeln(r);
}