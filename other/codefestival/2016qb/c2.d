import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias E = Tuple!(int, "d", long, "c");

void main()
{
    auto wh = readln.split.to!(long[]);
    auto W = wh[0];
    auto H = wh[1];
    E[] es;
    foreach (_; 0..W) {
        es ~= E(0, readln.chomp.to!long);
    }
    foreach (_; 0..H) {
        es ~= E(1, readln.chomp.to!long);
    }
    sort!"a.c < b.c"(es);

    auto X = (W+1) * (H+1) - 1, w = W+1, h = H+1;
    long r;
    foreach (e; es) {
        if (X == 0) break;
        if (e.d == 1) {
            r += w * e.c;
            X -= w;
            --h;
        } else {
            r += h * e.c;
            X -= h;
            --w;
        }
    }
    writeln(r);
}

/*

2 2
3
5
2
7

2
3
5
7


* * *
* * *
* * *

2 * 3
3 * 2
5 * 2
7 * 1

6+6+10+7 = 29
*/