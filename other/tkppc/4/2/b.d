import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5] T;
int[10^^5] CS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        T[A] ~= B;
        T[B] ~= A;
    }
    foreach (c; readln.split.to!(int[])) CS[c-1] = 1;

    int count(int i, int p) {
        int r;
        foreach (j; T[i]) if (j != p) {
            r = count(j, i);
            if (r) break;
        }
        return r + CS[i];
    }

    foreach (i, c; CS) if (c) {
        int r, x;
        foreach (j; T[i]) {
            if (x == 2) break;
            auto s = count(j, i.to!int);
            if (s) {
                r += s;
                ++x;
            }
        }
        writeln(r+1 == M ? "Yes" : "trumpet");
        return;
    }
}