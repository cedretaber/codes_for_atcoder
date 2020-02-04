import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abx = readln.split.to!(long[]);
    auto A = abx[0];
    auto B = abx[1];
    auto X = abx[2];

    if (A * 10L^^9 + B * 10 <= X) {
        writeln(10L^^9);
        return;
    }

    long l, r = 10L^^9;
    while (l+1 < r) {
        auto m = (l+r)/2;
        auto n = m;
        long k;
        while (n) {
            ++k;
            n /= 10;
        }
        if (A * m + B * k <= X) {
            l = m;
        } else {
            r = m;
        }
    }

    writeln(l);
}