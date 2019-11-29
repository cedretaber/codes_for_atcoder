import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto M = readln.chomp.to!int;
    long b = 0, res;
    foreach (_; 0..M) {
        auto dc = readln.split.to!(long[]);
        int d = dc[0].to!int;
        auto c = dc[1];
        int[] at;
        while (c != 1) {
            if (c%2 == 1) at ~= d;
            c /= 2;
            res += c;
            d *= 2;
            if (d >= 10) {
                res += c;
                d = d/10 + d%10;
            }
        }
        while (!at.empty) {
            res += 1;
            d = d + at[0];
            at = at[1..$];
            if (d >= 10) {
                res += 1;
                d = d/10 + d%10;
            }
        }
        if (b == 0) {
            b = d;
        } else {
            res += 1;
            b += d;
            if (b >= 10) {
                res += 1;
                b = b/10 + b%10;
            }
        }
    }
    writeln(res);
}