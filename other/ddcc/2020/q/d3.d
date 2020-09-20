import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto M = readln.chomp.to!int;
    long r, x = -1;
    while (M--) {
        auto dc = readln.split.to!(long[]);
        auto d = dc[0];
        auto c = dc[1];
        if (x == -1) {
            --c;
            x = d;
        }
        while (c) {
            if (c%2 == 1) {
                ++r;
                x += d;
                if (x > 9) {
                    ++r;
                    x = x/10 + x%10;
                }
            }
            r += c/2;
            d *= 2;
            if (d > 9) {
                r += c/2;
                d = d/10 + d%10;
            }
            c /= 2;
        }
    }
    writeln(r);
}