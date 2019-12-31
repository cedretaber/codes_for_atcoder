import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = new long[][](N, N);
    foreach (i; 0..N-1) {
        foreach (j, a; readln.split.to!(long[])) {
            as[i][i+j+1] = a;
            as[i+j+1][i] = a;
        }
    }

    auto DP = new long[](1<<N);
    foreach (i; 0..1<<N) {
        long x;
        foreach (j; 0..N) if (i & (1<<j)) {
            foreach (k; 0..N) if (i & (1<<k)) {
                x += as[j][k];
            }
        }
        DP[i] = x;
    }

    long solve(int i, int x, uint s, uint t) {
        if (i == N) {
            if (x == 0) return solve(0, 1, s, t);
            return DP[s] + DP[t] + DP[(~(s | t)) & ((1<<N)-1)];
        }

        if (x == 0) {
            return max(solve(i+1, x, s, t), solve(i+1, x, s | (1<<i), t));
        } else {
            if (s & (1<<i)) return solve(i+1, x, s, t);
            return max(solve(i+1, x, s, t), solve(i+1, x, s, t | (1<<i)));
        }
    }

    writeln(solve(0, 0, 0, 0) / 2);
}