import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto XS = readln.split.to!(int[]);
    auto YS = XS.dup;
    sort(XS);
    auto XA = XS[N/2-1];
    auto XB = XS[N/2];

    foreach (y; YS)
        writeln(y <= XA ? XB : XA);
}