import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5] HS, MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i, h; readln.split.to!(long[])) HS[i] = h;

    MEMO[0..N] = -1;

    long solve(int i) {
        if (MEMO[i] != -1) return MEMO[i];
        if (i == N-1) return 0;
        if (i == N-2) return MEMO[i] = solve(i+1) + abs(HS[i] - HS[i+1]);
        return MEMO[i] = min(solve(i+1) + abs(HS[i] - HS[i+1]), solve(i+2) + abs(HS[i] - HS[i+2]));
    }

    writeln(solve(0));
}