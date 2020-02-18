import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nbc = readln.split.to!(long[]);
    auto N = nbc[0];
    auto B = nbc[1];
    auto C = nbc[2];
    auto AS = readln.split.to!(long[]);
    long s;
    foreach_reverse (a; AS) {
        auto x = min(B, C);
        s += x * a;
        C -= x;
        if (C == 0) break;
    }
    writeln(s);
}