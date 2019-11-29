import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    if (N <= 2) {
        writeln(0);
        return;
    }
    N -= 2;
    int r = N*(N%2 == 0 ? 2 : 1);
    for (;;) {
        N -= 2;
        if (N <= 0) break;
        r += N*2;
    }
    writeln(r);
}