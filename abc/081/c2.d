import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto K = nk[1];
    int[int] as;
    foreach (a; readln.split.to!(int[])) ++as[a];
    int[] bs;
    foreach (a; as.values) bs ~= a;
    sort!"a < b"(bs);
    int r;
    foreach (i; 0..max(0, bs.length.to!int - K)) r += bs[i];
    writeln(r);
}