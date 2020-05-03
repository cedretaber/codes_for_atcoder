import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto hs = readln.split.to!(int[]);
    auto bs = new bool[](N);
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        if (hs[A] > hs[B]) {
            bs[B] = true;
        } else if (hs[A] < hs[B]) {
            bs[A] = true;
        } else {
            bs[A] = true;
            bs[B] = true;
        }
    }
    int r;
    foreach (b; bs) if (!b) ++r;
    writeln(r);
}