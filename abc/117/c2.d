import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto XS = readln.split.to!(long[]);
    if (M-N <= 0) {
        writeln(0);
        return;
    }
    sort(XS);
    long[] ds;
    foreach (i; 0..M-1) ds ~= XS[i+1] - XS[i];
    sort(ds);
    writeln(reduce!"a + b"(0L, ds[0..M-N]));
}