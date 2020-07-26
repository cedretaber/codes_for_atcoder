import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias R = Tuple!(long, "x", long, "y", long, "p");

void main()
{
    auto N = readln.chomp.to!int;
    R[] rs;
    foreach (_; 0..N) {
        auto r = readln.split.to!(long[]);
        auto x = r[0];
        auto y = r[1];
        auto p = r[2];
        rs ~= R(x, y, p);
    }

    auto xs = new long[][](N, 1<<N);
    auto ys = new long[][](N, 1<<N);
    foreach (b; 0..2^^N) {
        foreach (i, r; rs) {
            xs[i][b] = abs(r.x) * r.p;
            ys[i][b] = abs(r.y) * r.p;
            foreach (j; 0..N) if (b & (1<<j)) {
                xs[i][b] = min(xs[i][b], abs(r.x - rs[j].x) * r.p);
                ys[i][b] = min(ys[i][b], abs(r.y - rs[j].y) * r.p);
            }
        }
    }

    auto res = new long[](N+1);
    res[] = long.max;
    foreach (b; 0..3^^N) {
        int c;
        uint x, y;
        foreach (i; 0..N) {
            if (b%3 == 1) {
                x |= (1<<i);
                ++c;
            } else if (b%3 == 2) {
                y |= (1<<i);
                ++c;
            }
            b /= 3;
        }
        long s;
        foreach (i; 0..N) s += min(xs[i][x], ys[i][y]);
        res[c] = min(res[c], s);
    }
    foreach (r; res[0..N+1]) writeln(r);
}