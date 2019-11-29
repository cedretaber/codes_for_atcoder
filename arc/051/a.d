import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto xyr = readln.split.to!(double[]);
    auto x1 = xyr[0];
    auto y1 = xyr[1];
    auto r = xyr[2];
    auto xy = readln.split.to!(double[]);
    auto x2 = xy[0];
    auto y2 = xy[1];
    auto x3 = xy[2];
    auto y3 = xy[3];

    if (
        sqrt((x1 - x2)^^2 + (y1 - y2)^^2) <= r &&
        sqrt((x1 - x2)^^2 + (y1 - y3)^^2) <= r &&
        sqrt((x1 - x3)^^2 + (y1 - y2)^^2) <= r &&
        sqrt((x1 - x3)^^2 + (y1 - y3)^^2) <= r
    ) {
        writeln("YES");
        writeln("NO");
    } else
    if (
        x2 <= x1-r && x1+r <= x3 &&
        y2 <= y1-r && y1+r <= y3
    ) {
        writeln("NO");
        writeln("YES");
    } else {
        writeln("YES");
        writeln("YES");
    }
}