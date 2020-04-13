import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias S = Tuple!(int, "t", long, "d");

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    long K = nk[1];
    S[] ss;
    foreach (_; 0..N) {
        auto td = readln.split.to!(int[]);
        ss ~= S(td[0], td[1]);
    }
    sort!"a.t == b.t ? a.d > b.d : a.t < b.t"(ss);
    long[] ts, os;
    int last = -1;
    foreach (s; ss) {
        if (s.t != last) {
            last = s.t;
            ts ~= s.d;
        } else {
            os ~= s.d;
        }
    }
    sort!"a > b"(ts);
    foreach (i; 1..ts.length) ts[i] += ts[i-1];
    sort!"a > b"(os);
    foreach (i; 1..os.length) os[i] += os[i-1];

    long max_d;
    foreach (k; 1..K+1) {
        if (ts.length < k) continue;
        if (os.length < K-k) continue;
        max_d = max(max_d, k*k + ts[k-1] + (K-k == 0 ? 0 : os[K-k-1]));
    }
    writeln(max_d);
}