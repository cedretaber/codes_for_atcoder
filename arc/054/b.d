import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

double P;

double t(double x)
{
    return x + P / 2.0 ^^ (x/1.5);
}

void main()
{
    P = readln.chomp.to!double;

    double l = 0, r = P;
    foreach (_; 0..100000) {
        auto a = t((l*2+r)/3);
        auto b = t((l+r*2)/3);
        if (a > b) {
            l = (l*2+r)/3;
        } else {
            r = (l+r*2)/3;
        }
    }
    writefln("%.010f", t(r));
}