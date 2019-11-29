import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][700] PS;
bool[700] F;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto QS = new bool[][](N, N);
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        PS[A] ~= B;
        PS[B] ~= A;
        QS[A][B] = true;
        QS[B][A] = true;
    }

    auto SS = new int[](N);
    foreach (int i; 1..N) SS[i] = SS[i-1] + i;

    int[] solve(int i, int[] ss) {
        int[] ret = ss;
        foreach (n; PS[i]) if (!F[n]) {
            int[] r;
            foreach (s; ss) if (!QS[n][s]) goto ng;
            F[n] = true;
            r = solve(n, ss ~ n);
            F[n] = false;
            if (r.length > ret.length) ret = r;
            ng:
        }
        return ret;
    }
    auto ss = solve(0, [0]);

    auto FX = new int[](N);
    foreach (s; ss) FX[s] = 1;

    int x = -1;
    foreach (int i; 0..N) if (FX[i] != 1) {
        x = i;
        break;
    }
    if (x == -1) {
        writeln(SS[N/2] + SS[N/2+N%2]);
        return;
    }

    auto ts = solve(x, [x]);
    foreach (t; ts) FX[t] = FX[t] == 1 ? 3 : 2;
    int d;
    foreach (f; FX) {
        if (f == 0) {
            writeln(-1);
            return;
        } else if (f == 3) ++d;
    }

    auto sc = ss.length;
    auto tc = ts.length;
    while (d) {
        if (sc > tc) {
            --sc;
        } else {
            --tc;
        }
        --d;
    }
    writeln(SS[sc-1] + SS[tc-1]);
}