import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias RS = Tuple!(long, "i", long, "c", char, "d");

void main()
{
    auto nl = readln.split.to!(int[]);
    auto N = nl[0];
    long L = nl[1];

    RS[] rss;
    char last_d = 'S';
    RS rs;
    long s;
    foreach (_; 0..N) {
        auto xd = readln.split;
        auto X = xd[0].to!int-1;
        auto d = xd[1][0];
        if (last_d == 'S') {
            rs = RS(X, 1, d);
        } else if (d == last_d) {
            if (d == 'R') {
                s += (X - rs.i - 1) * rs.c;
                rs = RS(X, rs.c + 1, d);
            } else {
                s += (X - rs.i - rs.c);
                rs = RS(rs.i, rs.c + 1, d);
            }
        } else {
            rss ~= rs;
            rs = RS(X, 1, d);
        }
        last_d = d;
    }
    rss ~= rs;

    if (rss[0].d == 'L') {
        rs = rss[0];
        rss = rss[1..$];

        s += rs.i * rs.c;
    }

    size_t i;
    while (i < rss.length) {
        if (i+1 == rss.length && rss[i].d == 'R') {
            rs = rss[i];
            s += (L-1 - rs.i) * rs.c;
            break;
        } else {
            s += (rss[i+1].i - rss[i].i - 1) * max(rss[i].c, rss[i+1].c);
            i += 2;
        }
    }
    writeln(s);
}