import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto nab = readln.split.to!(long[]);
    auto n = nab[0];
    auto a = nab[1];
    auto b = nab[2];

    auto hs = new long[n];
    foreach (i; 0..n) {
        hs[i] = readln.chomp.to!long;
    }

    auto d = a - b;

    bool check(long n) {
        auto nn = n;
        foreach (h; hs) {
            h -= b * n;
            if (h <= 0) {
                continue;
            } else if (h <= d * nn) {
                nn -= (h + d - 1) / d;
            } else {
                return false;
            }
        }
        return true;
    }

    auto min = 0;
    auto max = 10^^9;
    while (min + 1 != max) {
        auto piv = (min + max) / 2;
        if (check(piv)) {
            max = piv;
        } else {
            min = piv;
        }
    }
    writeln(max);
}