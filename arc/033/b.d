import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[int] M;

void main()
{
    auto ab = readln.split.to!(int[]);
    foreach (a; readln.split.to!(int[])) {
        M[a] = 1;
    }
    foreach (b; readln.split.to!(int[])) {
        if (b !in M) M[b] = 0;
        ++M[b];
    }
    double x = 0, y = 0;
    foreach (_, c; M) {
        y += 1;
        if (c == 2) x += 1;
    }
    writefln("%.010f", x / y);
}