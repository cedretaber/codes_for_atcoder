import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nkmr = readln.split.to!(long[]);
    auto N = nkmr[0];
    auto K = nkmr[1];
    auto M = nkmr[2];
    auto R = nkmr[3];
    long[] ss;
    foreach (_; 0..N-1) ss ~= readln.chomp.to!long;
    sort!"a > b"(ss);

    long sm;
    foreach (s; ss[0..min(N-1, K)]) sm += s;
    if (sm >= R*K) {
        writeln(0);
        return;
    }
    sm = M;
    foreach (s; ss[0..K-1]) sm += s;
    if (sm < R*K) {
        writeln(-1);
        return;
    }

    long l, r = M;
    while (l+1 < r) {
        auto m = (l+r)/2;
        long[] xs = [m];
        foreach (s; ss) xs ~= s;
        sort!"a > b"(xs);
        sm = 0;
        foreach (s; xs[0..K]) sm += s;
        if (sm >= R*K) {
            r = m;
        } else {
            l = m;
        }
    }
    writeln(r);
}