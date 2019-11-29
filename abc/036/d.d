import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

long[10^^5][2] MEMO;
bool[10^^5] XS;
int[][10^^5] NS, MS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        NS[a] ~= b;
        NS[b] ~= a;
    }

    void prepare(int i) {
        foreach (n; NS[i]) {
            if (XS[n]) continue;
            XS[n] = true;
            MS[i] ~= n;
            prepare(n);
        }
    }
    XS[0] = true;
    prepare(0);

    long solve(int i, int c) {
        if (MEMO[c][i]) return MEMO[c][i];
        long r = 1;
        foreach (m; MS[i]) {
            long s = solve(m, 0);
            if (!c) s = (s + solve(m, 1)) % P;
            r = (r * s) % P;
        }
        return MEMO[c][i] = r;
    }

    writeln((solve(0, 0) + solve(0, 1)) % P);
}