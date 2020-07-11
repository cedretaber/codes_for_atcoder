import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range, core.bitop;

alias C = Tuple!(int, "i", int, "k", long, "p");

void solve()
{
    auto N = readln.chomp.to!int;
    long res;
    C[] fs, bs;
    foreach (i; 0..N) {
        auto klr = readln.split.to!(int[]);
        auto K = klr[0];
        auto L = klr[1];
        auto R = klr[2];
        auto c = C(i, K, 0);
        if (L >= R) {
            c.p = L - R;
            res += R;
            fs ~= c;
        } else {
            c.p = R - L;
            res += L;
            bs ~= c;
        }
    }
    sort!"a.p == b.p ? a.k < b.k : a.p > b.p"(fs);
    auto frbt = redBlackTree(1.iota(fs.length+1));
    foreach (f; fs) {
        auto lb = frbt.lowerBound(f.k+1);
        if (!lb.empty) {
            res += f.p;
            frbt.removeKey(lb.back);
        }
    }
    sort!"a.p == b.p ? a.k > b.k : a.p > b.p"(bs);
    auto brbt = redBlackTree((fs.length+1).iota(N+1));
    foreach (b; bs) {
        auto ub = brbt.upperBound(b.k);
        if (!ub.empty) {
            res += b.p;
            brbt.removeKey(ub.front);
        }
    }
    writeln(res);
}

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) solve();
}