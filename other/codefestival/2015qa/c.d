import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nt = readln.split.to!(int[]);
    auto N = nt[0];
    auto T = nt[1];
    int[] AS, DS;
    int s;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        AS ~= ab[0];
        s += ab[0];
        DS ~= ab[0] - ab[1];
    }
    if (s <= T) {
        writeln(0);
        return;
    }
    sort!"a > b"(DS);
    int t;
    foreach (d; DS) {
        s -= d;
        ++t;
        if (s <= T) {
            writeln(t);
            return;
        }
    }
    writeln(-1);
}