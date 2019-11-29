import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto lr = readln.split.to!(long[]);
    auto L = lr[0];
    auto R = min(L+2020, lr[1]+1);

    long x = long.max;
    foreach (i; L..R) {
        foreach (j; i+1..R) {
            x = min(x, i*j%2019);
        }
    }
    writeln(x);
}