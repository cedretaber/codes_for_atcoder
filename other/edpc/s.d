import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto K = readln.chomp.to!(char[]);
    auto D = readln.chomp.to!long;

    auto DP1 = new long[][](2, D);
    auto DP2 = new long[][](2, D);
    foreach (i, c; K) {
        if (i == 0) {
            foreach (x; 0..c-'0') {
                ++DP1[0][x % D];
            }
            ++DP1[1][(c-'0') % D];
        } else {
            foreach (x; 0..D) {
                foreach (y; 0..10) {
                    DP1[0][(x+y)%D] = (DP1[0][(x+y)%D] + DP2[0][x]) % P;
                }
                foreach (y; 0..c-'0') {
                    DP1[0][(x+y)%D] = (DP1[0][(x+y)%D] + DP2[1][x]) % P;
                }
                DP1[1][(x+c-'0')%D] = (DP1[1][(x+c-'0')%D] + DP2[1][x]) % P;
            }
        }
        DP2[0][] = DP1[0][].dup;
        DP2[1][] = DP1[1][].dup;
        DP1[0][] = 0;
        DP1[1][] = 0;
    }
    writeln((DP2[1][0] + DP2[0][0] - 1 + P) % P);
}