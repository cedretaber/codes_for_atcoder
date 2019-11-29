import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[2][10^^5*2] DP;

void main()
{
    auto S = readln.chomp.to!string;

    foreach_reverse (i; 0..S.length) {
        if (i == S.length-1) {
            DP[i][0] = 1;
            DP[i][1] = int.min;
        } else if (i == S.length-2) {
            DP[i][0] = S[i] == S[i+1] ? int.min : 2;
            DP[i][1] = 1;
        } else {
            if (S[i] == S[i+1]) {
                DP[i][0] = DP[i+1][1] + 1;
            } else {
                DP[i][0] = max(DP[i+1][0], DP[i+1][1]) + 1;
            }
            if (i >= S.length-3 || (DP[i] == DP[i+2] && S[i+1] == S[i+3])) {
                DP[i][1] = DP[i+2][0] + 1;
            } else {
                DP[i][1] = max(DP[i+2][0], DP[i+2][1]) + 1;
            }
        }
    }

    writeln(max(DP[0][0], DP[0][1]));
}