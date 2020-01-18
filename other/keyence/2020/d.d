import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import core.bitop;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);

    auto DP = new int[][](51, 2^^N);
    foreach (ref dp; DP) dp[] = -1;

    int solve(uint s, int p) {
        auto i = popcnt(s);
        if (i == N) return 0;
        if (DP[p][s] == -1) {
            int r = int.max/2;
            foreach (j; 0..N) if (!(s & (1<<j))) {
                auto x = (i+j)%2 == 0 ? AS[j] : BS[j];
                if (x < p) continue;
                int d;
                foreach (k; j+1..N) if (s & (1<<k)) ++d;
                r = min(r, solve(s | (1<<j), x) + d);
            }
            DP[p][s] = r;
        }
        return DP[p][s];
    }
    auto r = solve(0, 0);
    writeln(r >= int.max/2 ? -1 : r);
}