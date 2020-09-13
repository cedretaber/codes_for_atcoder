import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 10L^^9+7;

void main()
{
    auto S = readln.chomp.to!int;
    auto DP = new long[](S+1);
    DP[] = -1;
    
    long solve(int s) {
        if (s == 0) return 1;
        if (s < 3) return 0;
        if (DP[s] == -1) {
            long r;
            foreach (i; 3..s+1) {
                (r += solve(s-i)) %= P;
            }
            DP[s] = r;
        }
        return DP[s];
    }
    writeln(solve(S));
}