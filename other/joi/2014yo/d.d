import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10007;
enum M = ['J': 1, 'O': 2, 'I': 4];

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;

    auto DP = new int[][](N-1, 8);
    foreach (ref dp; DP) dp[] = -1;
    int solve(int i, uint p) {
        if (i == N-1) {
            int r;
            foreach (x; 0..8) if (p&x && x&M[S[i]]) ++r;
            return r;
        }

        if (DP[i][p] == -1) {
            int r;
            foreach (x; 0..8) if (p&x && x&M[S[i]]) r = (r + solve(i+1, x)) % P;
            DP[i][p] = r;
        }
        return DP[i][p];
    }

    writeln(solve(0, 1));
}