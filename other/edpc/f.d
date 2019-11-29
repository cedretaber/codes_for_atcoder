import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][] MAX, MEMO;

void main()
{
    auto s = readln.chomp.to!(wchar[]);
    auto t = readln.chomp.to!(wchar[]);

    MEMO.length = s.length;
    MAX.length = s.length;
    foreach (i; 0..s.length) {
        MEMO[i].length = t.length;
        MAX[i].length = t.length;
        MAX[i][] = -1;
    }

    int solve(int i, int j) {
        if (i == s.length || j == t.length) return 0;
        if (MAX[i][j] != -1) return MAX[i][j];

        auto r1 = s[i] == t[j] ? solve(i+1, j+1) + 1 : -1;
        auto r2 = solve(i+1, j);
        auto r3 = solve(i, j+1);

        auto max_r = max(r1, r2, r3);

        if (max_r == r1) {
            return MAX[i][j] = r1;
        } else if (max_r == r2) {
            MEMO[i][j] = 1;
            return MAX[i][j] = r2;
        } else {
            MEMO[i][j] = 2;
            return MAX[i][j] = r3;
        }
    }
    solve(0, 0);

    wchar[] answer(int i, int j) {
        if (i == s.length || j == t.length) return [];

        switch (MEMO[i][j]) {
            case 0:
                return s[i] ~ answer(i+1, j+1);
            case 1:
                return answer(i+1, j);
            case 2:
                return answer(i, j+1);
            default:
                return [];
        }
    }
    writeln(answer(0, 0));
}