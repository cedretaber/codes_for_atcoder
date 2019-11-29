import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(wchar[]);

    ulong ok;
    foreach (i; 0..N) {
        ok |= 1<<i;
        ok |= 1<<(N+i);
    }

    long[ulong] memo;
    long solve(int i, int j, ulong s) {
        if (i == 2*N) return s == ok ? 1L : 0L;
        if (s in memo) return memo[s];
        auto r1 = solve(i+1, j, s);
        if (s & (1<<i)) return memo[s] = r1;
        long r2;
        foreach_reverse (x; 0..j) {
            if (s & (1<<x)) continue;
            if (S[i] != S[x]) continue;
            r2 += solve(i+1, x, s | (1<<i) | (1<<x));
        }
        return memo[s] = r1 + r2;
    }

    writeln(solve(0, 2*N, 0));
}