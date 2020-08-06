import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    int[] cs;
    foreach (_; 0..N) cs ~= readln.chomp.to!int;

    long[] fs;
    foreach (c; cs) {
        long f;
        foreach (d; cs) if (c%d == 0) f += 1;
        fs ~= f;
    }

    double r = 0;
    foreach (f; fs) {
        if (f == 0) {
            r += 1;
        } else if (f%2 == 0) {
            r += 0.5;
        } else {
            r += (f+1).to!double / (2*f).to!double;
        }
    }
    writefln!"%.12f"(r);
}

/*

+   +   +
* * * * *  3/5

+   +   +   +
* * * * * * *  4/7

*/