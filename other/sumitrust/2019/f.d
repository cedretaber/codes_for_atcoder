import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto tt = readln.split.to!(long[]);
    auto T1 = tt[0];
    auto T2 = tt[1];
    auto aa = readln.split.to!(long[]);
    auto A1 = aa[0];
    auto A2 = aa[1];
    auto bb = readln.split.to!(long[]);
    auto B1 = bb[0];
    auto B2 = bb[1];

    if (B1 < A1) {
        swap(A1, B1);
        swap(A2, B2);
    }

    auto x = (A1 - B1) * T1;
    auto y = (A2 - B2) * T2;

    if (x+y < 0) {
        writeln(0);
    } else if (x+y == 0) {
        writeln("infinity");
    } else {
        auto d = x+y;
        writeln(-x/d * 2 + (-x%d == 0 ? 0 : 1));
    }
}