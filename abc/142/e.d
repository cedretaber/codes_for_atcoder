import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Key = Tuple!(long, "a", uint, "cs");
Key[10^^3] KS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (i; 0..M) {
        auto a = readln.split.to!(long[])[0];
        uint cs;
        foreach (j; readln.split.to!(int[])) cs |= (1<<(j-1));
        KS[i] = Key(a, cs);
    }
    auto DP = new long[][](10^^3, 2^^12);

    long solve(int i, uint s) {
        if (s == (1<<N)-1) return 0;
        if (i == M) return long.min;
        if (DP[i][s] != 0) return DP[i][s];

        auto r1 = solve(i+1, s);

        if ((KS[i].cs | s) == s) {
            DP[i][s] = r1;
            return r1;
        }

        auto r2 = solve(i+1, s | KS[i].cs) + KS[i].a;

        if (r1 < 0) {
            DP[i][s] = r2;
        } else if (r2 < 0) {
            DP[i][s] = r1;
        } else {
            DP[i][s] = min(r1, r2);
        }
        return DP[i][s];
    }

    auto r = solve(0, 0);
    writeln(r < 0 ? -1 : r);
}