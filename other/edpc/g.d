import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5] PS;
int[10^^5] MEMO;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        PS[xy[0]-1] ~= xy[1]-1;
    }

    MEMO[0..N] = -1;

    int solve(int from) {
        if (MEMO[from] != -1) return MEMO[from];
        if (PS[from].empty) return MEMO[from] = 0;

        int max_p;
        foreach (to; PS[from]) {
            max_p = max(max_p, solve(to));
        }
        return MEMO[from] = max_p + 1;
    }

    foreach (i; 0..N) solve(i);

    int ret;
    foreach (mp; MEMO[0..N]) ret = max(ret, mp);
    writeln(ret);
}