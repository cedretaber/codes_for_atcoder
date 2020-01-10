import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto ll = readln.split.to!(double[]);
    auto l1 = ll[0];
    auto l2 = ll[1];
    auto l3 = ll[2];

    auto r = (l1+l2+l3)^^2*PI;
    if (l1 > l2+l3) {
        r -= (l1-l2-l3)^^2*PI;
    } else if (l3 > l1+l2) {
        r -= (l3-l1-l2)^^2*PI;
    } else if (l2 > l1+l3) {
        r -= (l2-l1-l3)^^2*PI;
    }
    writefln("%.010f", r);
}