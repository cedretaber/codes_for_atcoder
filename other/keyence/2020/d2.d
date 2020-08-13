import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.bitop;

alias X = Tuple!(int, "n", int, "f", int, "t");

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);

    auto DP = new int[][](1<<N, 51);
    foreach (ref dp; DP) dp[] = -1;

    int solve(uint s, int p) {
        auto i = popcnt(s);
        if (i == N) return 0;

        if (DP[s][p] == -1) {
            int r = int.max/3;
            foreach (j; 0..N) if (!(s&(1<<j))) {
                auto x = (i+j)%2 == 0 ? AS[j] : BS[j];
                if (x < p) continue;
                int d;
                foreach (k; j+1..N) if (s&(1<<k)) ++d;
                r = min(r, solve(s | (1<<j), x) + d);
            }
            DP[s][p] = r;
        }
        return DP[s][p];
    }
    auto r = solve(0, 0);
    writeln(r >= int.max/3 ? -1 : r);
}