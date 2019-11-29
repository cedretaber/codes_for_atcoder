import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long MOD = 10^^9+7;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    wchar[][] MAP;
    long[][] MEMO;
    MAP.length = H;
    MEMO.length = H;
    foreach (i; 0..H) {
        MAP[i] = readln.chomp.to!(wchar[]);
        MEMO[i].length = W;
        MEMO[i][] = -1;
    }

    long solve(int x, int y) {
        if (x < 0 || x >= W || y < 0 || y >= H) return 0;
        if (x == W-1 && y == H-1) return 1;
        if (MAP[y][x] == '#') return 0;
        if (MEMO[y][x] != -1) return MEMO[y][x];
        return MEMO[y][x] = (solve(x+1, y) + solve(x, y+1)) % MOD;
    }

    writeln(solve(0, 0));
}