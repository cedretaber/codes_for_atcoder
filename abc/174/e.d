import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    long[] AS;
    long max_a;
    foreach (a; readln.split.to!(long[])) {
        max_a = max(max_a, a);
        AS ~= a;
    }

    long l, r = max_a;
    while (l+1 < r) {
        auto m = (l+r)/2;
        long k;
        foreach (a; AS) {
            k += a/m;
            if (a%m == 0) --k;
        }
        if (k <= K) {
            r = m;
        } else {
            l = m;
        }
    }
    writeln(r);
}

/*

2 3
7 9

9/2 7
9/2 7/2
9/3 7/2

*/