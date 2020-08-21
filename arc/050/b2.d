import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto rb = readln.split.to!(long[]);
    auto R = rb[0];
    auto B = rb[1];
    auto xy = readln.split.to!(long[]);
    auto x = xy[0];
    auto y = xy[1];

    long l, r = max(R, B);
    while (l+1 < r) {
        auto m = (l+r)/2;
        if (R-m >= 0 && B-m >= 0 && (R-m) / (x-1) + (B-m) / (y-1) >= m) {
            l = m;
        } else {
            r = m;
        }
    }
    writeln(l);
}