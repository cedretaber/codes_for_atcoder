import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto ps = new int[](10^^6+1);
    foreach (i; 2..10^^6+1) if (ps[i] == 0) {
        auto x = i;
        while (x <= 10^^6) {
            ps[x] = i;
            x += i;
        }
    }

    auto N = readln.chomp.to!int;
    auto ns = new int[](10^^6+1);
    foreach (a; readln.split.to!(int[])) {
        while (a != 1) {
            auto p = ps[a];
            ns[p] += 1;
            while (a % p == 0) a /= p;
        }
    }

    auto pc = true;
    foreach (p; ns) {
        if (p == N) {
            writeln("not coprime");
            return;
        } else if (p > 1) {
            pc = false;
        }
    }
    writeln(pc ? "pairwise coprime" : "setwise coprime");
}