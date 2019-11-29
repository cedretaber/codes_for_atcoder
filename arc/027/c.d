import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias T = Tuple!(int, "t", int, "h");

T[300] TS;

void main()
{
    auto xy = readln.split.to!(int[]);
    auto X = xy[0];
    auto Y = xy[1];
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto th = readln.split.to!(int[]);
        TS[i] = T(th[0], th[1]);
    }

    auto DP = new int[][][](N, X+1, Y+1);
    foreach (n; 0..N) {
        foreach (x; 0..X+1) {
            foreach (y; 0..Y+1) {
                auto t = TS[n].t;
                auto h = TS[n].h;
                if (t > x + y || x == 0) {
                    DP[n][x][y] = n == 0 ? 0 : DP[n-1][x][y];
                } else {
                    DP[n][x][y] = n == 0 ? h : max(
                        DP[n-1][x][y],
                        DP[n-1][x-1+min(0, y-t+1)][max(0, y-t+1)] + h
                    );
                }
            }
        }
    }
    writeln(DP[N-1][X][Y]);
}