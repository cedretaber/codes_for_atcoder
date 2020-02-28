import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum DELTA = 1.0e-8;

void main()
{
    auto P = readln.chomp.to!double;

    double f(double x) {
        return x + P / (2.0^^(x/1.5));
    }
    double fp(double x) {
        return (f(x + DELTA) - f(x)) / DELTA;
    }

    double l = 0, r = 200;
    foreach (_; 0..1000) {
        auto m = (l+r)/2;
        if (fp(m) < 0) {
            l = m;
        } else {
            r = m;
        }
    }
    writefln("%.10f", f(l));
}