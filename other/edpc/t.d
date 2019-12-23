import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!long;
    auto s = readln.chomp.to!(char[]);
    auto DP = new long[][](N, N);
    foreach (i; 0..N) DP[0][i] = 1;
    foreach (i; 1..N) {
        long c;
        if (s[i-1] == '<') {
            foreach_reverse (j; 0..N-i+1) {
                DP[i][j] = c;
                c = (c + DP[i-1][j]) % P;
            }
        } else {
            foreach (j; 0..N-i+1) {
                c = (c + DP[i-1][j]) % P;
                DP[i][j] = c;
            }
        }
    }
    writeln(DP[$-1][0]);
}