import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.split[3].to!int;
    auto as = readln.split.to!(long[]);
    auto bs = readln.split.to!(long[]);
    auto cs = readln.split.to!(long[]);

    long[] ss, ts;
    foreach (a; as) {
        foreach (b; bs) {
            ss ~= a + b;
        }
    }
    sort!"a > b"(ss);
    ss = ss[0..min($, K)];
    foreach (c; cs) {
        foreach (s; ss) {
            ts ~= c + s;
        }
    }
    sort!"a > b"(ts);
    foreach (t; ts[0..min($, K)]) writeln(t);
}