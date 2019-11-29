import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto s = readln.chomp.to!(dchar[]);
    auto xy = readln.split.to!(int[]);
    auto x = xy[0];
    auto y = xy[1];

    int buf;
    int[] os;
    foreach (c; s) {
        if (c == 'F') {
            ++buf;
        } else {
            os ~= buf;
            buf = 0;
        }
    }
    os ~= buf;

    int[] hs;
    int[] vs;
    foreach (i, o; os) {
        if (i&1)
            vs ~= o;
        else
            hs ~= o;
    }

    int hp, vp;
    if (hs.length > 0) {
        hp = hs[0];
        hs = hs[1..$];
    }

    hs.sort!"a > b";
    foreach (h; hs) {
        hp += hp > x ? -h : h;
    }
    if (hp != x) {
        writeln("No");
        return;
    }

    vs.sort!"a > b";
    foreach (v; vs) {
        vp += vp > y ? -v : v;
    }
    writeln(vp == y ? "Yes" : "No");
}