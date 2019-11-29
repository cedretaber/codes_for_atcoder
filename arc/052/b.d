import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

double[10^^4*2+1] M;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    
    M[] = 0.0;
    foreach (_; 0..N) {
        auto xrh = readln.split.to!(int[]);
        auto x = xrh[0];
        auto r = xrh[1].to!double;
        auto h = xrh[2];
        auto d = r^^2 * PI * h / 3.0;
        foreach_reverse (i; x..x+h) {
            M[i] += d * ((h-i+x).to!double / h.to!double)^^3;
        }
        foreach (i; 0..x) {
            M[i] += d;
        }
    }

    foreach (_; 0..Q) {
        auto ab = readln.split.to!(int[]);
        writefln("%.010f", M[ab[0]] - M[ab[1]]);
    }
}