import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

double[10^^5] AS;
double[10^^5][3] MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(double[]);

    double solve(int i, int f) {
        if (i == N-1) return AS[N-1] * (f-1);
        if (!MEMO[f][i].isNaN) return MEMO[f][i];
        return MEMO[f][i] = max(
            solve(i+1, 2) + AS[i] * (f-1),
            solve(i+1, 0) + AS[i] * -(f-1)
        );
    }

    writeln(solve(0, 2).to!long);
}