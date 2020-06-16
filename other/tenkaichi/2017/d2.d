import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    ulong K = nk[1];
    long[31] rs;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        ulong A = ab[0];
        auto B = ab[1];
        if ((A&K) == A) rs[30] += B;
        foreach (i, ref r; rs) {
            if (
                (K&(1L<<i)) &&
                !(A&(1L<<i)) &&
                (((K>>(i+1))&(A>>(i+1))) == (A>>(i+1)))
            ) {
                r += B;
            }
        }
    }
    long r;
    foreach (ref rr; rs) r = max(r, rr);
    writeln(r);
}