import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    long r;
    int k = K;
    while (k <= N) {
        ++r;
        k += K;
    }
    r ^^= 3;

    if (K % 2 == 0) {
        long s;
        k = K / 2;
        while (k <= N) {
            ++s;
            k += K;
        }
        r += s^^3;
    }

    writeln(r);
}