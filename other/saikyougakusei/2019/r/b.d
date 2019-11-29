import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    long K = nk[1];
    auto AS = readln.split.to!(int[]);

    long[] xs, ys;
    xs.length = N;
    ys.length = N;
    foreach (i, a; AS) {
        long x, y;
        foreach (j, b; AS) {
            if (b > a && j < i) ++x;
            if (b > a) ++y;
        }
        xs[i] = x;
        ys[i] = y;
    }
    long r;
    auto k = (K * (K - 1) / 2) % P;
    foreach (i; 0..N) {
        r = (r + (K *xs[i]) % P + (k * ys[i]) % P) % P;
    }
    writeln(r);
}