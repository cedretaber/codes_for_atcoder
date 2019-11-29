import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^4*3] CS, DP;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (int i; 0..N) {
        CS[i] = readln.chomp.to!int;
    }
    DP[0] = CS[0];
    size_t j;
    for (size_t i; i < N; ++i) {
        if (DP[j] < CS[i]) {
            DP[++j] = CS[i];
        } else if (DP[0] > CS[i]) {
            DP[0] = CS[i];
        } else {
            size_t l, r = j;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (DP[m] > CS[i]) {
                    r = m;
                } else {
                    l = m;
                }
            }
            DP[r] = CS[i];
        }
    }
    writeln(N-j-1);
}