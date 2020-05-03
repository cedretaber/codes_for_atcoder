import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto ss = new bool[](N);
    foreach (_; 0..K) {
        readln;
        foreach (i; readln.split.to!(int[])) ss[i-1] = true;
    }
    int r;
    foreach (s; ss) if (!s) ++r;
    writeln(r);
}