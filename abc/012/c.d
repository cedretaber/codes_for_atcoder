import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int kuku()
{
    int n;
    foreach (i; 1..10) foreach (j; 1..10) n += i*j;
    return n;
}

enum KUKU = kuku();

void main()
{
    auto N = readln.chomp.to!int;
    auto c = KUKU - N;

    foreach (i; 1..10) {
        if (c%i == 0 && c/i < 10) writefln("%d x %d", i, c/i);
    }
}