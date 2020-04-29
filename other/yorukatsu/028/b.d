import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nt = readln.split.to!(long[]);
    auto N = nt[0];
    auto T = nt[1];
    auto ts = readln.split.to!(long[]);
    ts ~= long.max;
    long st;
    foreach (i; 0..N) st += min(T, ts[i+1] - ts[i]);
    writeln(st);
}