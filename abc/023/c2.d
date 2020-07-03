import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias P = Tuple!(int, "r", int, "c");

void main()
{
    auto rck = readln.split.to!(int[]);
    auto R = rck[0];
    auto C = rck[1];
    long K = rck[2];
    auto rs = new long[](R);
    auto cs = new long[](C);
    P[] ps;
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto rc = readln.split.to!(int[]);
        auto r = rc[0]-1;
        auto c = rc[1]-1;
        rs[r] += 1;
        cs[c] += 1;
        ps ~= P(r, c);
    }
    long[long] cm;
    foreach (n; cs) cm[n] += 1;
    long res;
    foreach (r; rs) if (K-r in cm) {
        res += cm[K - r];
    }
    foreach (p; ps) {
        auto k = rs[p.r] + cs[p.c];
        if (k == K) {
            --res;
        } else if (k == K+1) {
            ++res;
        }
    }
    writeln(res);
}