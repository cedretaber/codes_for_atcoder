import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "a", int, "b");

P[10^^5*2] PS;
int[10^^5*2] L;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(int[]);
        sort(ab);
        PS[i] = P(ab[1], ab[0]);
    }
    sort!"a.a == b.a ? a.b > b.b : a.a < b.a"(PS[0..N]);
    int i;
    L[0] = PS[0].b;
    foreach (p; PS[1..N]) {
        if (L[i] < p.b) {
            L[++i] = p.b;
        } else if (L[0] >= p.b) {
            L[0] = p.b;
        } else {
            int l, r = i;
            while (r-l > 1) {
                auto m = (l+r)/2;
                if (L[m] >= p.b) {
                    r = m;
                } else {
                    l = m;
                }
            }
            L[r] = p.b;
        }
    }
    writeln(i+1);
}