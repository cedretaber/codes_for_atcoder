import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto AS = readln.split.to!(long[]);

    int[60] bs;
    foreach (a; AS) {
        foreach (i; 0..60) if (a & (1L<<i)) bs[60-i-1] += 1;
    }
    long X;
    bool u;
    foreach (i; 0..60) {
        X <<= 1;
        auto j = 60-i-1;
        if (bs[i] <= N/2) {
            if ((K & (1L<<j)) || u) X += 1;
        } else {
            if (K & (1L<<j)) u = true;
        }
    }
    long r;
    foreach (a; AS) r += a^X;
    writeln(r);
}