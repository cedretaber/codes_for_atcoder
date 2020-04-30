import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nab = readln.split.to!(int[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];
    auto vs = readln.split.to!(double[]);
    sort!"a > b"(vs);
    auto cs = new double[](N);
    cs[0] = vs[0];
    foreach (i; 1..N) cs[i] = cs[i-1] + vs[i];

    double l = 0, r = 10.0^^15+1;
    foreach (_i; 0..100) {
        auto m = (l+r)/2;
        if (cs[A-1] / A >= m) goto ok;
        r = m;
        continue;
        ok:
        l = m;
    }
    writefln("%.12f", l);

    auto pt = new long[][](N+1, N+1);
    pt[0][0] = 1;
    foreach (i; 1..N+1) {
        pt[i][0] = 1;
        pt[i][i] = 1;
        foreach (j; 1..i) {
            pt[i][j] = pt[i-1][j-1] + pt[i-1][j];
        }
    }

    if (vs[0] == vs[A-1]) {
        long n;
        foreach (v; vs) if (v == vs[0]) ++n;
        long s;
        foreach (k; A..min(B, n)+1) s += pt[n][k];
        writeln(s);
    } else {
        long k, n;
        foreach (i, v; vs) if (v == vs[A-1]) {
            ++n;
            if (i < A) ++k;
        }
        writeln(pt[n][k]);
    }
}