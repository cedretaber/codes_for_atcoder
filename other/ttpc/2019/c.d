import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

uint bits_msb(uint v)
{
    v = v | (v >>  1);
    v = v | (v >>  2);
    v = v | (v >>  4);
    v = v | (v >>  8);
    v = v | (v >> 16);
    return v ^ (v >> 1);
}

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    uint X = nx[1];
    auto as = readln.split.to!(int[]);
    uint x;
    foreach (a; as) {
        if (a < 0) continue;
        x ^= a;
    }
    auto y = X ^ x;
    foreach (ref a; as) if (a < 0) {
        if (y > X) {
            auto yy = bits_msb(y);
            if (bits_msb(y) > bits_msb(X)) {
                writeln("-1");
                return;
            }
            a = yy;
            y = y ^ yy;
        } else {
            a = y;
            y = 0;
        }
    }

    writeln(y != 0 ? "-1" : as.to!(string[]).join(" "));
}