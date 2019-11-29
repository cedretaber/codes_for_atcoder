import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xytv = readln.split.to!(double[]);
    auto x1 = xytv[0];
    auto y1 = xytv[1];
    auto x2 = xytv[2];
    auto y2 = xytv[3];
    auto T = xytv[4];
    auto V = xytv[5];

    auto N = readln.chomp.to!int;
    bool r;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(double[]);
        if (r) continue;
        auto x = xy[0];
        auto y = xy[1];
        auto l = sqrt((x1-x)^^2 + (y1-y)^^2) + sqrt((x-x2)^^2 + (y-y2)^^2);
        r = l/V <= T;
    }
    writeln(r ? "YES" : "NO");
}