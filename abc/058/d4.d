import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 10L^^9+7;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    auto xx = readln.split.to!(long[]);
    auto yy = readln.split.to!(long[]);
    long[] xs, ys;
    foreach (i; 1..N) xs ~= xx[i] - xx[i-1];
    foreach (i; 1..M) ys ~= yy[i] - yy[i-1];

    long e;
    foreach (i; 0..N-1) (e += xs[i] * (i+1) % P * (N-i-1) % P) %= P;
    long r;
    foreach (i; 0..M-1) (r += ys[i] * e % P * (i+1) % P * (M-i-1) % P) %= P;
    writeln(r);
}