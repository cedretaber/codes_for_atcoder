import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5*2] AS;
long[10^^5*2][5] MEMO;

void main()
{
    auto L = readln.chomp.to!int;
    foreach (i; 0..L) {
        AS[i] = readln.chomp.to!long;
    }

    foreach (ref m; MEMO) m[] = -1;

    long solve(int i, int t) {
        if (i == L) return 0;
        if (MEMO[t][i] != -1) return MEMO[t][i];
        return MEMO[t][i] = min(
            t > 0 ? long.max : AS[i] + solve(i+1, 0),
            t > 1 ? long.max : (AS[i] == 0 ? 2 : AS[i] % 2) + solve(i+1, 1),
            t > 2 ? long.max : (AS[i] == 0 ? 1 : (AS[i]+1) % 2) + solve(i+1, 2),
            t > 3 ? long.max : (AS[i] == 0 ? 2 : AS[i] % 2) + solve(i+1, 3),
            AS[i] + solve(i+1, 4)
        );
    }

    writeln(solve(0, 0));
}