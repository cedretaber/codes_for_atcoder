import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto CS = readln.chomp.to!(char[]);
    auto N = CS.length;
    int[] ps;
    ps.length = N;
    foreach (i; 0..N) {
        int x;
        foreach (j, c; CS) {
            if (c == 'x') continue;
            x |= 1<<j;
        }
        ps[i] = x;
        CS = CS[1..$] ~ CS[0];
    }
    
    auto memo = new int[][](N, 2^^N);
    int solve(int i, int cs) {
        if (cs == ((1<<N)-1)) return 0;
        if (i == N) {
            return 11;
        } else {
            if (memo[i][cs] == 0) {
                memo[i][cs] = min(solve(i+1, cs), solve(i+1, cs | ps[i]) + 1);
            }
            return memo[i][cs];
        }
    }
    writeln(solve(0, 0));
}