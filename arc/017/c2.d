import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];
    int[] ws;
    foreach (_; 0..N) ws ~= readln.chomp.to!int;

    int[] as = [0];
    foreach (w; ws[0..min(N, 16)]) {
        auto l = as.length;
        foreach (a; as[0..l]) as ~= a + w;
    }
    if (N <= 16) {
        writeln(as.count(X));
        return;
    }
    int[] bs = [0];
    foreach (w; ws[16..$]) {
        auto l = bs.length;
        foreach (b; bs[0..l]) bs ~= b + w;
    }
    int[int] cs;
    foreach (b; bs) ++cs[b];

    int r;
    foreach (a; as) if ((X-a) in cs) r += cs[X-a];
    writeln(r);
}