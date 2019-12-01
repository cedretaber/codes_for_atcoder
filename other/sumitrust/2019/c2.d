import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp.to!int;
    auto n = X / 100;
    auto d = X % 100;

    int c;
    while (d >= 5) {
        d -= 5;
        ++c;
    }
    if (d >= 4) {
        d -= 4;
        ++c;
    }
    if (d >= 3) {
        d -= 3;
        ++c;
    }
    if (d >= 2) {
        d -= 2;
        ++c;
    }
    if (d >= 1) {
        ++c;
    }
    writeln(c <= n ? 1 : 0);
}