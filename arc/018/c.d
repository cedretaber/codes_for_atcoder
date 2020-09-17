import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto xap = readln.split.to!(int[]);
    auto X = xap[0];
    auto A = xap[1];
    auto P = xap[2];

    if (A%P == 0) {
        writeln(X < P ? 0 : (N-1)*2);
        return;
    }

    int[] xs, ys;
    foreach (i; 0..N*M) {
        xs ~= X;
        ys ~= X;
        X = (X + A) % P;
    }
    sort(ys);
    int[int] ms;
    foreach (i, y; ys) {
        ms[y] = i.to!int/M;
    }

    alias S = Tuple!(int, "r", int, "c");
    auto ps = new S[][N];
    foreach (ii, x; xs) {
        auto i = ii.to!int;
        ps[ms[x]] ~= S(i/M, i%M);
    }
    long res;
    foreach (ii, pp; ps) {
        auto i = ii.to!int;
        sort!"a.c < b.c"(pp);
        foreach (jj, p; pp) {
            auto j = jj.to!int;
            res += abs(i - p.r) + abs(j - p.c);
        }
    }
    writeln(res);
}