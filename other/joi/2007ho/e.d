import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias B = Tuple!(long, "p", long, "q", int, "r", int, "b");

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = new int[](N);
    B[] bs;
    foreach (_; 0..N) {
        auto pqrb = readln.split.to!(int[]);
        auto p = pqrb[0];
        auto q = pqrb[1];
        auto r = pqrb[2]-1;
        auto b = pqrb[3]-1;
        bs ~= B(p / gcd(p, q), q / gcd(p, q), r, b);
        if (r >= 0) ++ps[r];
        if (b >= 0) ++ps[b];
    }

    long solve(int i) {
        auto r = (bs[i].r == -1 ? 1 : solve(bs[i].r)) * bs[i].p;
        auto b = (bs[i].b == -1 ? 1 : solve(bs[i].b)) * bs[i].q;
        auto x = r / gcd(r, b) * b;
        return x / bs[i].p + x / bs[i].q;
    }

    foreach (i, p; ps) if (p == 0) {
        writeln(solve(i.to!int));
        return;
    }
}