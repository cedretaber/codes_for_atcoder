import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5*2] T;
long[10^^5*2] C;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    foreach (i; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0] - 1;
        auto b = ab[1] - 1;
        T[a] ~= b;
        T[b] ~= a;
    }
    foreach (_; 0..Q) {
        auto px = readln.split.to!(int[]);
        auto P = px[0] - 1;
        long X = px[1];
        C[P] += X;
    }

    void walk(int i, int p) {
        foreach (j; T[i]) if (j != p) {
            C[j] += C[i];
            walk(j, i);
        }
    }
    walk(0, -1);

    writeln(C[0..N].to!(string[]).join(" "));
}