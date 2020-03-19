import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto S = readln.chomp;
    auto DP = new long[][](S.length, 4);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int i, int s) {
        if (i == S.length) return s == 3 ? 1 : 0;

        if (DP[i][s] == -1) {
            long r;
            auto c = S[i];
            if (c == 'A' || c == '?') {
                r = (r + solve(i+1, s)) % P;
                if (s == 0) r = (r + solve(i+1, s+1)) % P;
            }
            if (c == 'B' || c == '?') {
                r = (r + solve(i+1, s)) % P;
                if (s == 1) r = (r + solve(i+1, s+1)) % P;
            }
            if (c == 'C' || c == '?') {
                r = (r + solve(i+1, s)) % P;
                if (s == 2) r = (r + solve(i+1, s+1)) % P;
            }
            DP[i][s] = r;
        }
        return DP[i][s];
    }
    writeln(solve(0, 0));
}