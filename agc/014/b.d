import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto qs = new int[](N);
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        ++qs[ab[0]-1];
        ++qs[ab[1]-1];
    }
    foreach (q; qs) {
        if (q%2 == 1) {
            writeln("NO");
            return;
        }
    }
    writeln("YES");
}