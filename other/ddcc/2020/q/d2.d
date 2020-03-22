import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto M = readln.chomp.to!int;
    long r, n = -1;
    foreach (_; 0..M) {
        auto dc = readln.split.to!(long[]);
        auto d = dc[0];
        auto c = dc[1];
        if (n == -1) {
            --c;
            n = d;
        }
        while (c) {
            if (c % 2 == 1) {
                ++r;
                n += d;
                if (n >= 10) {
                    ++r;
                    n = 1 + n%10;
                }
            }
            c /= 2;
            r += c;
            d *= 2;
            if (d >= 10) {
                r += c;
                d = 1 + d%10;
            }
        }
    }
    writeln(r);
}