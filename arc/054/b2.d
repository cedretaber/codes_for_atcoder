import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto P = readln.chomp.to!double;

    double calc(double x) {
        return x + P / (2.0^^(x/1.5));
    }

    double l = 0, r = 200;
    foreach (_; 0..10000) {
        auto a = (l*2+r)/3;
        auto b = (l+r*2)/3;
        if (calc(a) > calc(b)) {
            l = a;
        } else {
            r = b;
        }
    }
    writefln("%.10f", calc(l));
}