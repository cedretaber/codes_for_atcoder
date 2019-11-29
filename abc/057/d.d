import std.stdio, std.conv, std.string, std.array, std.algorithm, std.range;

ulong[51][51] CMB;

ulong comb(ulong n, ulong r)
{
    if (CMB[n][r]) {
        return CMB[n][r];
    } else if(r > n) {
        return CMB[n][r] = 0;
    } else if (n == 0 || r == 0) {
        return CMB[n][r] = 1;
    } else {
        return CMB[n][r] = comb(n-1, r-1) + comb(n-1, r);
    }
}

void main()
{
    auto nab = readln.split.to!(int[]);
    auto a = nab[1];
    auto b = nab[2];

    auto vs = readln.split.to!(ulong[]);
    vs.sort();
    vs.reverse();

    writefln("%0.6f", reduce!"a + b"(0L, vs[0..a]) / a.to!double);

    if (vs.length > a && vs[0] == vs[a]) {
        auto cnt = vs.count(vs[a]);
        auto v_max = b > cnt ? cnt : b;
        ulong ret = 0;
        foreach (i; a..v_max+1)
            ret += comb(cnt, i);
        writeln(ret);
    } else if (vs.length > a && vs[a-1] == vs[a]) {
        auto cnt = vs.count(vs[a]);
        auto space = vs[0..a].count(vs[a]);
        writeln(comb(cnt, space));
    } else {
        writeln(1);
    }
}