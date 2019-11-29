import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto AS = readln.split.to!(long[]);

    long solve(int i, int k, long s) {
        if (k == 0) {
            long r;
            while (s) {
                auto n = s%10;
                if (n >= 5) r += 1;
                r += n%5;
                s /= 10;
            }
            return r;
        }

        if (i == N) return long.max;

        return min(solve(i+1, k, s), solve(i+1, k-1, s + AS[i]));
    }

    writeln(solve(0, K, 0));
}