import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmx = readln.split.to!(int[]);
    auto N = nmx[0];
    auto M = nmx[1];
    auto X = nmx[2];

    int[][] cas;
    foreach (_; 0..N) {
        cas ~= readln.split.to!(int[]);
    }

    auto ms = new int[](M);
    long solve(int i) {
        if (i == N) {
            foreach (m; ms) if (m < X) {
                return int.max/3;
            }
            return 0;
        } else {
            auto r1 = solve(i+1);
            foreach (j, a; cas[i][1..$]) {
                ms[j] += a;
            }
            auto r2 = solve(i+1) + cas[i][0];
            foreach (j, a; cas[i][1..$]) {
                ms[j] -= a;
            }
            return min(r1, r2);
        }
    }
    auto r = solve(0);
    writeln(r >= int.max/3 ? -1 : r);
}