import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[] xs, ys;
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        xs ~= xy[0];
        ys ~= xy[1];
    }
    sort(xs);
    sort(ys);

    if (N >= xs.uniq.count + ys.uniq.count) {
        writeln(0);
        return;
    }

    int l, r = 10^^9+1;
    while (l+1 < r) {
        auto d = (l+r)/2;
        int k;
        int i = -1;
        foreach (x; xs) if (i < x) {
            ++k;
            i = x + d;
        }
        i = -1;
        foreach (y; ys) if (i < y) {
            ++k;
            i = y + d;
        }
        if (k <= N) {
            r = d;
        } else {
            l = d;
        }
    }
    writeln(r);
}