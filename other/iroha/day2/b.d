import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy = readln.split.to!(int[]);
    auto X = xy[0];
    auto Y = xy[1];
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    auto sxy = readln.split.to!(int[]);
    auto SX = sxy[0];
    auto SY = sxy[1];
    auto txy = readln.split.to!(int[]);
    auto TX = txy[0];
    auto TY = txy[1];

    auto b = A;
    auto a = (B - A) / X.to!double;
    double f(int x) {
        return x * a + b;
    }

    writeln((f(SX) < SY) == (f(TX) < TY) ? "No" : "Yes");
}