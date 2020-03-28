import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nxy = readln.split.to!(int[]);
    auto N = nxy[0];
    auto X = nxy[1]-1;
    auto Y = nxy[2]-1;

    auto G = new int[][](N, N);
    auto memo = new int[](N);
    void run(int i, int p, int n) {
        if (memo[i] < n) return;
        if (memo[i] < N) G[i][memo[i]] -= 1;
        memo[i] = n;
        G[i][n] += 1;
        if (i > 0 && p != i-1) run(i-1, i, n+1);
        if (i < N-1 && p != i+1) run(i+1, i, n+1);
        if (i == X && p != Y) run(Y, i, n+1);
        if (i == Y && p != X) run(X, i, n+1);
    }
    foreach (i; 0..N) {
        memo[] = int.max;
        run(i, -1, 0);
    }
    auto rr = new int[](N);
    foreach (i; 0..N) {
        foreach (j; 1..N) {
            rr[j] += G[i][j];
        }
    }
    foreach (r; rr[1..$]) writeln(r/2);
}