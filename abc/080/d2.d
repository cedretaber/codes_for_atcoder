import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

alias P = Tuple!(int, "s", int, "t");

void main()
{
    auto nc = readln.split.to!(int[]);
    auto N = nc[0];
    auto C = nc[1];
    P[][] cc;
    cc.length = C;
    foreach (_; 0..N) {
        auto stc = readln.split.to!(int[]);
        auto s = stc[0];
        auto t = stc[1];
        auto c = stc[2]-1;
        cc[c] ~= P(s, t);
    }
    foreach (ref c; cc) sort!"a.s < b.s"(c);
    P[] ps;
    foreach (c; cc) {
        foreach (i, p; c) {
            if (i == 0 || c[i-1].t != p.s) {
                ps ~= P(p.s-1, p.t);
            } else {
                ps[$-1].t = p.t;
            }
        }
    }
    auto ts = new int[](10^^5+1);
    foreach (p; ps) {
        ++ts[p.s];
        --ts[p.t];
    }
    int r;
    foreach (i, t; ts[0..$-1]) {
        r = max(r, t);
        ts[i+1] += t;
    }
    writeln(r);
}