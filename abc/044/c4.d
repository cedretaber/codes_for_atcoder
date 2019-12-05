import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto na = readln.split.to!(int[]);
    auto N = na[0];
    auto A = na[1];
    auto xs = readln.split.to!(int[]);

    auto DP = new long[][][](N+1, N+1, N*50+1);
    foreach (c; 1..N+1) {
        foreach (v; 0..N*50+1) {
            DP[N][c][v] = v%c == 0 && v/c == A ? 1 : 0;
        }
    }
    foreach_reverse (i; 0..N) {
        foreach (c; 0..N) {
            foreach (v; 0..N*50+1) {
                DP[i][c][v] = DP[i+1][c][v];
                if (c+1 <= N && v+xs[i] <= N*50) DP[i][c][v] += DP[i+1][c+1][v+xs[i]];
            }
        }
    }
    writeln(DP[0][0][0]);
}