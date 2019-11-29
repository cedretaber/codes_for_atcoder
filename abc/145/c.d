import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = new double[][](N, 2);
    foreach (i; 0..N) {
        auto xy = readln.split.to!(double[]);
        ps[i][0] = xy[0];
        ps[i][1] = xy[1];
    }
    auto xs = new int[](N);
    foreach (i; 0..N) xs[i] = i;
    double sum_d = 0;
    int cnt;
    do {
        double d = 0;
        auto x = ps[xs[0]][0], y = ps[xs[0]][1];
        foreach (j; 1..N) {
            auto i = xs[j];
            d += sqrt((x - ps[i][0])^^2 + (y - ps[i][1])^^2);
            x = ps[i][0];
            y = ps[i][1];
        }
        sum_d += d;
        ++cnt;
    } while (nextPermutation(xs));
    writefln("%.010f", sum_d / cnt);
}