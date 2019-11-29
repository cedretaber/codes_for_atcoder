import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(wchar[]);

    long[immutable(wchar[])][18] omemo;
    long solve(int i, wchar[] rs_, wchar[] bs_) {
        if (i == N) {
            auto rs = rs_.dup;
            reverse(rs);
            auto bs = bs_.dup;
            reverse(bs);
            long[long][long] memo;
            long dp(int i, int j) {
                if (i + j == N) return 1L;
                if (i in memo && j in memo[i]) return memo[i][j];
                long r1, r2;
                if (i < bs.length && S[N+i+j] == bs[i]) r1 = dp(i+1, j);
                if (j < rs.length && S[N+i+j] == rs[j]) r2 = dp(i, j+1);
                return memo[i][j] = r1 + r2;
            }
            auto ret = dp(0, 0);
            return ret;
        } else {
            auto key = (rs_ ~ "|" ~ bs_).idup;
            if (key in omemo[i]) return omemo[i][key];
            return omemo[i][key] = solve(i+1, rs_ ~ S[i], bs_) + solve(i+1, rs_, bs_ ~ S[i]);
        }
    }

    writeln(solve(0, [], []));
}