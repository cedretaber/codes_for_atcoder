import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    double[] ps;
    foreach (p; readln.split.to!(int[])) ps ~= (1 + p).to!double / 2.0 ;
    double p = 0;
    foreach (i; 0..K) p += ps[i];
    auto max_p = p;
    foreach (i; K..N) {
        p = p - ps[i-K] + ps[i];
        max_p = max(max_p, p);
    }
    writefln("%.10f", max_p);
}