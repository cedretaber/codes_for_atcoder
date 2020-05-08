import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto S = readln.chomp;
    auto N = S.length;
    auto DP = new long[][](N+1, 4);
    DP[0][0] = 1;

    foreach (i, c; S) {
        foreach (j; 0..4) DP[i+1][j] = DP[i][j] * (c == '?' ? 3 : 1) % P;
        switch (c) {
            case 'A': (DP[i+1][1] += DP[i][0]) %= P; break;
            case 'B': (DP[i+1][2] += DP[i][1]) %= P; break;
            case 'C': (DP[i+1][3] += DP[i][2]) %= P; break;
            default:
                (DP[i+1][1] += DP[i][0]) %= P;
                (DP[i+1][2] += DP[i][1]) %= P;
                (DP[i+1][3] += DP[i][2]) %= P;
        }
    }

    writeln(DP[N][3]);
}