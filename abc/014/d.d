import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto T = new int[][N];
    foreach (_; 1..N) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0]-1;
        auto y = xy[1]-1;
        T[x] ~= y;
        T[y] ~= x;
    }
    auto LS = new int[](N);
    auto PS = new int[][](N, 18);
    void walk_len(int i, int p, int l) {
        LS[i] = l;
        PS[i][0] = p;
        foreach (j; T[i]) if (j != p) walk_len(j, i, l+1);
    }
    walk_len(0, -1, 0);
    foreach (k; 0..17) {
        foreach (i; 0..N) {
            if (PS[i][k] < 0) {
                PS[i][k+1] = -1;
            } else {
                PS[i][k+1] = PS[PS[i][k]][k];
            }
        }
    }

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;

        if (LS[a] > LS[b]) swap(a, b);
        auto c = b;
        foreach (k; 0..18) if (((LS[a] - LS[c])>>k) & 1) {
            c = PS[c][k];
        }

        if (a == c) {
            writeln(LS[b] - LS[a] + 1);
        } else {
            auto l = a, r = c;
            foreach_reverse (k; 0..18) if (PS[l][k] != PS[r][k]) {
                l = PS[l][k];
                r = PS[r][k];
            }
            c = PS[l][0];
            writeln(LS[a] + LS[b] - LS[c]*2 + 1);
        }
    }
}