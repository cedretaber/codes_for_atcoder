import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto dn = readln.split.to!(int[]);
    auto D = dn[0];
    auto N = dn[1];
    int[] as, bs, cs, ds;
    foreach (_; 0..D) ds ~= readln.chomp.to!int;
    foreach (_; 0..N) {
        auto abc = readln.split.to!(int[]);
        as ~= abc[0];
        bs ~= abc[1];
        cs ~= abc[2];
    }

    auto DP = new int[][](D, 101);
    foreach (ref dp; DP) dp[] = -1;
    int solve(int i, int p) {
        if (i == D) return 0;
        if (DP[i][p] == -1) {
            auto r = int.min/3;
            foreach (j; 0..N) if (as[j] <= ds[i] && ds[i] <= bs[j]) {
                r = max(r, solve(i+1, cs[j]) + abs(p - cs[j]));
            }
            DP[i][p] = r;
        }
        return DP[i][p];
    }
    int r;
    foreach (i; 0..N) if (as[i] <= ds[0] && ds[0] <= bs[i]) r = max(r, solve(1, cs[i]));
    writeln(r);
}