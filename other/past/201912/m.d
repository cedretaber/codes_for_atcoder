import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii, core.bitop;

alias Monster = Tuple!(double, "a", double, "b", bool, "is_help");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    Monster[] ms;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(double[]);
        ms ~= Monster(ab[0], ab[1], false);
    }
    foreach (_; 0..M) {
        auto cd = readln.split.to!(double[]);
        ms ~= Monster(cd[0], cd[1], true);
    }
    
    double l = 0, r = 500001;
    foreach (_; 0..100) {
        auto m = (l+r)/2;
        sort!((x, y) => x.b - m * x.a > y.b - m * y.a)(ms);
        double s = 0;
        bool used;
        int cnt, i;
        for (;;) {
            if (cnt == 5) break;
            if (ms[i].is_help) {
                if (used) {
                    ++i;
                    continue;
                }
                used = true;
            }
            s += ms[i].b - m * ms[i].a;
            ++i;
            ++cnt;
        }
        if (s >= 0) {
            l = m;
        } else {
            r = m;
        }
    }
    writefln("%.10f", l);
}