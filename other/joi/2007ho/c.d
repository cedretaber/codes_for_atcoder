import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "x", int, "y");

void main()
{
    auto N = readln.chomp.to!int;
    P[] ps;
    bool[P] pt;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(int[]);
        auto p = P(xy[0], xy[1]);
        ps ~= p;
        pt[p] = true;
    }

    int r; 
    foreach (i; 0..N-1) {
        foreach (j; i+1..N) {
            auto p = ps[i];
            auto q = ps[j];
            auto xd = q.x - p.x;
            auto yd = q.y - p.y;
            if ((xd+yd)%2 == 1) continue;
            auto s = P(p.x + (xd-yd)/2, p.y + (yd+xd)/2);
            auto t = P(p.x + (xd+yd)/2, p.y + (yd-xd)/2);
            if (s in pt && t in pt) {
                auto x_max = max(p.x, q.x, s.x, t.x);
                auto x_min = min(p.x, q.x, s.x, t.x);
                auto y_max = max(p.y, q.y, s.y, t.y);
                auto y_min = min(p.y, q.y, s.y, t.y);
                r = max(r, (x_max - x_min) * (y_max - y_min) - abs(p.x - s.x) * abs(p.y - s.y) * 2);
            }
        }
    }
    writeln(r);
}