import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "h", int, "w");
alias C = Tuple!(int, "i", int, "c");

void main()
{
    auto hwm = readln.split.to!(int[]);
    auto H = hwm[0];
    auto W = hwm[1];
    auto M = hwm[2];
    auto hs = new C[](H);
    foreach (i, ref c; hs) c.i = i.to!int;
    auto ws = new C[](W);
    foreach (i, ref c; ws) c.i = i.to!int;
    bool[P] ps;
    foreach (_; 0..M) {
        auto hw = readln.split.to!(int[]);
        auto p = P(hw[0]-1, hw[1]-1);
        ps[p] = true;
        ++hs[p.h].c;
        ++ws[p.w].c;
    }
    sort!"a.c > b.c"(hs);
    sort!"a.c > b.c"(ws);
    auto max_h = hs[0].c;
    auto max_w = ws[0].c;

    foreach (h; hs) {
        if (h.c < max_h) break;
        foreach (w; ws) {
            if (w.c < max_w) break;
            if (P(h.i, w.i) !in ps) {
                writeln(max_h + max_w);
                return;
            }
        }
    }
    writeln(max_h + max_w - 1);
}