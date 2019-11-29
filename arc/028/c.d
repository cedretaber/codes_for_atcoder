import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[][10^^5] T;
int[10^^5] R;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (int i; 1..N) {
        auto p = readln.chomp.to!int;
        T[i] ~= p;
        T[p] ~= i;
    }

    int solve(int i, int p) {
        int s, max_b;
        foreach (j; T[i]) if (j != p) {
            auto x = solve(j, i);
            s += x;
            max_b = max(max_b, x);
        }
        if (p >= 0) {
            max_b = max(max_b, N - s - 1);
        }
        R[i] = max_b;
        return s + 1;
    }
    solve(0, -1);
    foreach (i; 0..N) writeln(R[i]);
}