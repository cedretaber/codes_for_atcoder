import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

auto P = 10L^^9+7;

long[100][5][5][5] MEMO;

void main()
{
    auto N = readln.chomp.to!int;

    foreach (ref xx; MEMO) foreach (ref yy; xx) foreach (ref zz; yy) foreach (ref memo; zz) memo = -1;

    long solve(int i, int x, int y, int z) {
        if (i == N) return 1;
        if (MEMO[z][y][x][i] != -1) return MEMO[z][y][x][i];
        long r = (solve(i+1, y, z, 1) + solve(i+1, y, z, 4)) % P;
        if ( !(
            (y == 1 && z == 3) ||
            (x == 1 && z == 3) ||
            (y == 3 && z == 1) ||
            (x == 1 && y == 3)) ) r = (r + solve(i+1, y, z, 2)) % P;
        if ( !(y == 1 && z == 2) ) r = (r + solve(i+1, y, z, 3)) % P;
        return MEMO[z][y][x][i] = r;
    }

    writeln(solve(0, 0, 0, 0));
}