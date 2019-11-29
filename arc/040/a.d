import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    int r, b;
    foreach (_; 0..N) foreach (c; readln.chomp) {
        if (c == 'R') {
            ++r;
        } else if (c == 'B') {
            ++b;
        }
    }
    writeln(r == b ? "DRAW" : r > b ? "TAKAHASHI" : "AOKI");
}