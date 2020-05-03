import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(long, "x", long, "y", long, "d", long, "c");

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    P[] ps;
    long xs, ys;
    foreach (_; 0..N) {
        auto p = readln.split.to!(long[]);
        xs ~= p[0];
        ys ~= p[1];
        xs ~= p[0] + p[2];
        ys ~= p[1] + p[2];
        ps ~= P(p[0], p[1], p[2], p[3]);
    }
    sort(xs);
    xs = xs.uniq();
    auto xlen = xs.length;
    sort(ys);
    ys = ys.uniq();
    auto ylen = ys.length;
    int[long] xi, yi;
    foreach (i, x; xs) xi[x] = i.to!int;
    foreach (i, y; ys) yi[y] = i.to!int;

    auto cxs = new long[](xlen+1);
    auto cys = new long[](ylen+1);
    foreach (p; ps) {
        cxs[p.x] += p.c;
        cxs[p.x+p.d+1] -= p.c;
        cys[p.y] += p.c;
        cys[p.y+p.d+1] -= p.c;
    }
    foreach (i; 0..xlen) cxs[i+1] += cxs[i];
    foreach (i; 0..ylen) cys[i+1] += cys[i];
}