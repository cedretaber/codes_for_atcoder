import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto HS = readln.split.to!(long[]);
    if (K >= N) {
        writeln(0);
        return;
    }
    sort!"a > b"(HS);
    long d;
    foreach (h; HS[K..$]) d += h;
    writeln(d);
}