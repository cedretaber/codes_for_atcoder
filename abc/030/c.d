import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto xy = readln.split.to!(long[]);
    auto X = xy[0];
    auto Y = xy[1];
    auto as = readln.split.to!(long[]);
    auto bs = readln.split.to!(long[]);

    int[] aa;
    aa.length = N;
    foreach (ref a; aa) a = -1;

    foreach_reverse (i; 0..N) {
        if (bs[M-1] < as[i]+X) {
            aa[i] = 0;
            continue;
        }
        size_t l, r = M-1;
        while (l+1 != r) {
            auto m = (l+r)/2;
            if (bs[m] < as[i]+X) {
                l = m;
            } else {
                r = m;
            }
        }
        if (bs[l] >= as[i]+X) r = l;
        auto b = r;
        if (as[N-1] < bs[b]+Y) {
            aa[i] = 1;
            continue;
        }
        l = 0; r = N-1;
        while (l+1 != r) {
            auto m = (l+r)/2;
            if (as[m] < bs[b]+Y) {
                l = m;
            } else {
                r = m;
            }
        }
        if (as[l] >= bs[b]+Y) r = l;
        aa[i] = aa[r] + 1;
    }
    long r;
    foreach (a; aa) r = max(r, a);
    writeln(r);
}