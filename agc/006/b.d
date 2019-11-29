import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto x = nx[1];

    if (x == 1 || x == N*2-1) {
        writeln("No");
        return;
    }
    writeln("Yes");

    int[] line;
    bool[] memo;
    line.length = N*2-1;
    memo.length = N*2;

    line[N-1] = x;
    memo[x] = true;
    line[N-2] = 1;
    memo[1] = true;
    line[N] = N*2-1;
    memo[N*2-1] = true;
    if (N > 2) {
        int i = N*2-2;
        while (memo[i]) --i;
        line[N-3] = i;
        memo[i] = true;

        int j = 2;
        while (memo[j]) ++j;
        line[N+1] = j;
        memo[j] = true;
    }

    x = 3;
    foreach (ref n; line) if (n == 0) {
        while (memo[x]) ++x;
        n = x;
        memo[x++] = true;
    }

    foreach (n; line) writeln(n);
}