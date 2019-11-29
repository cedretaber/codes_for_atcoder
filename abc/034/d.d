import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct SW {
    double w;
    double s;

    double d(double c) {
        return (s+w) * (s/(s+w)*100 - c);
    }

    @property
    double concentration() {
        if (w+s == 0) return 0;
        return s / (w+s) * 100;
    }
}

SW[1000] SWS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    foreach (i; 0..N) {
        auto wp = readln.split.to!(double[]);
        auto s = wp[0] * wp[1] / 100;
        auto w = wp[0] - s;
        SWS[i] = SW(w, s);
    }

    double min_c = 0, max_c = 101;
    foreach (_; 0..1000) {
        auto mid_c = (min_c + max_c) / 2;
        sort!((a, b) => a.d(mid_c) > b.d(mid_c))(SWS[0..N]);
        auto sw_s = SW(0, 0);
        foreach (sw; SWS[0..K]) {
            sw_s.w += sw.w;
            sw_s.s += sw.s;
        }
        if (sw_s.concentration > mid_c) {
            min_c = mid_c;
        } else {
            max_c = mid_c;
        }
    }

    writefln("%0.10f", max_c);
}