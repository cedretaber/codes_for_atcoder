import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[int][2000] MEMO;
int N, Z, W;

void main()
{
    auto nzw = readln.split.to!(int[]);
    N = nzw[0];
    Z = nzw[1];
    W = nzw[2];
    auto AS = readln.split.to!(int[]);

    int solve(int i, int t, int z, int w) {
        if (i == N) return abs(z - w).to!int;

        auto key = t > 0 ? w : z * t;
        if (key in MEMO[i]) return MEMO[i][key];

        auto ret = t > 0 ? 0 : int.max;
        foreach (j; i..N) {
            if (t > 0) {
                z = AS[j];
                ret = max(ret, solve(j+1, -t, z, w));
            } else {
                w = AS[j];
                ret = min(ret, solve(j+1, -t, z, w));
            }
        }
        return MEMO[i][key] = ret;
    }

    writeln(solve(0, 1, Z, W));
}