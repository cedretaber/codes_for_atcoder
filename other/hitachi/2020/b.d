import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abm = readln.split.to!(int[]);
    auto A = abm[0];
    auto B = abm[1];
    auto M = abm[2];
    auto as = readln.split.to!(int[]);
    auto bs = readln.split.to!(int[]);
    int[] xs, ys, cs;
    foreach (_; 0..M) {
        auto xyc = readln.split.to!(int[]);
        xs ~= xyc[0]-1;
        ys ~= xyc[1]-1;
        cs ~= xyc[2];
    }

    auto min_c = int.max;
    foreach (i; 0..M) {
        min_c = min(min_c, as[xs[i]] + bs[ys[i]] - cs[i]);
    }
    sort(as);
    sort(bs);
    min_c = min(min_c, as[0] + bs[0]);
    writeln(min_c);
}