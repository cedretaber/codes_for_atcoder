import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias L = Tuple!(int, "level", long, "size", long, "patty");

L[51] LS;

void main()
{
    LS[0] = L(0, 1, 1);
    foreach (i; 0..50) {
        auto l = LS[i];
        LS[i+1] = L(i+1, l.size*2 + 3, l.patty*2 + 1);
    }

    long solve(long l, long i) {
        if (i <= l) return 0;
        if (l == 0) return 1;

        if (i <= LS[l-1].size + 1) {
            return solve(l-1, i-1);
        } else if (i == LS[l-1].size + 2) {
            return LS[l-1].patty + 1;
        } else {
            return solve(l-1, i-2-LS[l-1].size) + 1 + LS[l-1].patty;
        }
    }

    auto nx = readln.split.to!(long[]);
    auto N = nx[0];
    auto X = nx[1];

    writeln(solve(N, X));
}