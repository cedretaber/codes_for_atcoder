import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.split.to!(long[])[1];
    auto as = readln.split.to!(long[]);
    sort(as);
    long s;
    foreach (i; 0..K) s += as[i];
    writeln(s + K * (K-1) / 2);
}