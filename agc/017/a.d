import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto np = readln.split.to!(int[]);
    auto N = np[0];
    auto P = np[1];
    int even, odd;
    foreach (a; readln.split.to!(int[])) {
        if (a%2 == 0)  {
            ++even;
        } else {
            ++odd;
        }
    }
    long r = 2L^^even;
    if (odd == 0) {
        writeln(P == 1 ? 0 : r);
    } else {
        writeln(r * 2^^(odd-1));
    }
}