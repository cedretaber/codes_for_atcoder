import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias IJ = Tuple!(int, "i", int, "j", bool, "a");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto as = readln.split.to!(int[]);
    auto bs = readln.split.to!(int[]);

    auto memo = new IJ[](2*10^^6);
    foreach (i; 0..N) {
        foreach (j; 0..M) {
            auto w = as[i] + bs[j];
            if (memo[w].a) {
                auto ij = memo[w];
                writefln("%d %d %d %d", ij.i, ij.j, i, j);
                return;
            }
            memo[w] = IJ(i, j, true);
        }
    }
    writeln("-1");
}