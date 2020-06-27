import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto nmk = readln.split.to!(int[]);
    auto N = nmk[0];
    auto M = nmk[1];
    long K = nmk[2];

    auto AS = readln.split.to!(long[]);
    foreach (i, ref a; AS) if (i) a += AS[i-1];
    auto BS = readln.split.to!(long[]);
    foreach (i, ref b; BS) if (i) b += BS[i-1];

    long res;
    foreach (a; 0..N+1) {
        long k = a == 0 ? K : K - AS[a-1];
        if (k < 0) continue;

        if (BS[0] > k) {
            res = max(res, a);
        } else if (BS[$-1] <= k) {
            res = max(res, a + M);
        } else {
            int l, r = M-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (BS[m] <= k) {
                    l = m;
                } else {
                    r = m;
                }
            }
            res = max(res, a + r);
        }
    }
    writeln(res);
}