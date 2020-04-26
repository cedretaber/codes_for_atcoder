import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ad = readln.split.to!(int[]);
    auto A = ad[0];
    auto B = ad[1];
    auto C = ad[2];
    auto D = ad[3];
    for (;;) {
        C -= B;
        if (C <= 0) {
            writeln("Yes");
            return;
        }
        A -= D;
        if (A <= 0) {
            writeln("No");
            return;
        }
    }
}