import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abk = readln.split.to!(long[]);
    auto A = abk[0];
    auto B = abk[1];
    auto K = abk[2];

    if (A > K) {
        writefln("%d %d", A - K, B);
    } else if (A+B > K) {
        writefln("0 %d", A + B - K);
    } else {
        writeln("0 0");
    }
}