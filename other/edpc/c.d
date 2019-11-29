import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5] AS, BS, CS;
int[10^^5][3] MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto abc = readln.split.to!(int[]);
        AS[i] = abc[0];
        BS[i] = abc[1];
        CS[i] = abc[2];
    }

    int solve(int i, int b) {
        if (i == N) return 0;
        auto bb = b == -1 ? 0 : b;
        if (MEMO[bb][i]) return MEMO[bb][i];
        return MEMO[bb][i] =
            max(
                b == 0 ? -1 : solve(i+1, 0) + AS[i],
                b == 1 ? -1 : solve(i+1, 1) + BS[i],
                b == 2 ? -1 : solve(i+1, 2) + CS[i]
            );
    }

    writeln(solve(0, -1));
}