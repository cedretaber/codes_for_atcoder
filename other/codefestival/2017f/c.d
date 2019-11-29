import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ds = readln.split.to!(int[]);
    bool[24] T;
    T[0] = true;
    int solve(int i) {
        if (i == N) {
            int r = 12, j;
            foreach (k; 1..24) if (T[k]) {
                r = min(r, k - j, 24 - k + j);
                j = k;
            }
            r = min(r, 24 - j);
            return r;
        } else {
            if (ds[i] == 0) return 0;
            int j = ds[i], k = 24-ds[i], r1, r2;
            if (!T[j]) {
                T[j] = true;
                r1 = solve(i+1);
                T[j] = false;
            }
            if (!T[k]) {
                T[k] = true;
                r2 = solve(i+1);
                T[k] = false;
            }
            return max(r1, r2);
        }
    }
    writeln(solve(0));
}