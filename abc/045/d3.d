import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "a", int, "b");

void main()
{
    auto hwn = readln.split.to!(int[]);
    long H = hwn[0];
    long W = hwn[1];
    auto N = hwn[2];
    int[P] ps;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0];
        auto b = ab[1];
        static foreach (ad; [-1, 0, 1])
        static foreach (bd; [-1, 0, 1]) {{
            auto h = ad+a;
            auto w = bd+b;
            if (1 < h && h < H && 1 < w && w < W) ++ps[P(h, w)];
        }}
    }
    long[10] res;
    res[0] = (H-2) * (W-2);
    foreach (_, v; ps) {
        --res[0];
        ++res[v];
    }
    static foreach (i; 0..10) writeln(res[i]);
}