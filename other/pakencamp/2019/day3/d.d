import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    char[][5] FL;
    foreach (i; 0..5) FL[i] = readln.chomp.to!(char[]);
    auto cs = new int[][](N, 3);
    foreach (i; 0..N) {
        foreach (j; 0..5) {
            switch (FL[j][i]) {
                case 'R': ++cs[i][0]; break;
                case 'B': ++cs[i][1]; break;
                case 'W': ++cs[i][2]; break;
                default:
            }
        }
    }

    auto DP = new int[][](2, 3);
    foreach_reverse (i; 0..N) {
        foreach (j; 0..3) {
            auto x = int.max;
            if (j != 0) x = min(x, 5 - cs[i][0] + DP[(i+1)%2][0]);
            if (j != 1) x = min(x, 5 - cs[i][1] + DP[(i+1)%2][1]);
            if (j != 2) x = min(x, 5 - cs[i][2] + DP[(i+1)%2][2]);
            DP[i%2][j] = x;
        }
    }
    writeln(min(DP[0][0], DP[0][1], DP[0][2]));
}