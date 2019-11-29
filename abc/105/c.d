import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!long;
    if (!N) {
        writeln(0);
        return;
    }
    auto m = N < 0 ? 0 : 1;
    if (!m) N = -N;
    bool k;
    foreach (i; m..(62+m)) {
        if (i % 2 != m) continue;
        auto j = i + 1;
        auto x = N & (1L<<i);
        auto y = N & (1L<<j);
        if (k) {
            if (x) {
                if (y) {
                    N &= ~(1L<<i);
                    N &= ~(1L<<j);
                    k = true;
                } else {
                    N &= ~(1L<<i);
                    N |= 1L<<j;
                    k = false;
                }
            } else {
                if (y) {
                    N |= 1L<<i;
                    N &= ~(1L<<j);
                    k = true;
                } else {
                    N |= 1L<<i;
                    N |= 1L<<j;
                    k = false;
                }
            }
        } else {
            if (x) {
                if (y) {
                    N &= ~(1L<<j);
                    k = true;
                } else {
                    N |= 1L<<j;
                    k = false;
                }
            }
        }
    }
    writefln("%b", N);
}