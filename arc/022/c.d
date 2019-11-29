import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[][10^^5] T;
int[10^^5] L;

void distant(int i, int p, int l) {
    L[i] = l;
    foreach (j; T[i]) if (j != p) {
        distant(j, i, l+1);
    }
}

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        T[A] ~= B;
        T[B] ~= A;
    }
    distant(0, -1, 0);
    int p, l;
    foreach (int i; 0..N) {
        if (L[i] > l) {
            l = L[i];
            p = i;
        }
    }
    distant(p, -1, 0);
    int q;
    l = 0;
    foreach (int i; 0..N) {
        if (L[i] > l) {
            l = L[i];
            q = i;
        }
    }
    writefln("%d %d", p+1, q+1);
}