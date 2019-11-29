import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    uint[][] TS;
    TS.length = N;
    foreach (i; 0..N) {
        TS[i] = readln.split.to!(uint[]);
    }
    bool solve(int i, uint s) {
        if (i == N) return s == 0;
        foreach (n; TS[i]) {
            if (solve(i+1, s^n)) return true;
        }
        return false;
    }
    writeln(solve(0, 0) ? "Found" : "Nothing");
}