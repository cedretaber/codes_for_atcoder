import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = readln.split.to!(int[]);
    auto DP = new bool[][](N+1, N*100+1);
    void solve(int i, int s) {
        if (DP[i][s]) return;
        DP[i][s] = true;
        if (i == N) return;
        solve(i+1, s);
        solve(i+1, s + ps[i]);
    }
    solve(0, 0);
    int c;
    foreach (s; 0..N*100+1) {
        foreach (i; 0..N+1) {
            if (DP[i][s]) {
                ++c;
                break;
            }
        }
    }
    writeln(c);
}