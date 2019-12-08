import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[][][] MEMO;
    MEMO.length = N;
    foreach (i; 0..N) {
        auto A = readln.chomp.to!int;
        MEMO[i].length = A;
        foreach (j; 0..A) {
            auto xy = readln.split.to!(int[]);
            xy[0] -= 1;
            MEMO[i][j] = xy;
        }
    }

    int solve(int i, uint s) {
        if (i == N) {
            int c;
            foreach (j; 0..N) if (s & (1<<j)) {
                ++c;
                foreach (xy; MEMO[j]) {
                    auto x = xy[0];
                    auto y = xy[1];
                    if (!!(s & (1<<x)) != !!y) return 0;
                }
            }
            return c;
        } else {
            return max(solve(i+1, s), solve(i+1, s | (1<<i)));
        }
    }
    writeln(solve(0, 0));
}