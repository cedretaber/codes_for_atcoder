import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    long al;
    long[long] AM = [0: 0];
    foreach (i, a; readln.split.to!(long[])) {
        al = (al + a) % M;
        ++AM[al];
    }
    long r = AM[0];
    foreach (_, n; AM) r += n * (n-1) / 2;
    writeln(r);
}