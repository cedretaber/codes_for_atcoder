import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[2020] B;

void main()
{
    auto N = readln.chomp.to!int;
    auto K = new int[](N+1);
    foreach (i, x; readln.split.to!(int[])) {
        B[x] = i.to!int + 1;
        K[i+1] = x;
    }
    readln;
    foreach (a; readln.split.to!(int[])) {
        auto i = K[a];
        if (i == 2019 || B[i+1]) continue;
        B[i] = 0;
        B[i+1] = a;
        ++K[a];
    }
    foreach (c; K) if (c) writeln(c);
}