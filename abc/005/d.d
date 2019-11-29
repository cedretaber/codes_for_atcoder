import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[][] MAP;
    MAP.length = N;
    foreach (ref line; MAP) line = readln.split.to!(int[]);
    auto MEMO = new int[][][](N, N, N+1);
    foreach (k; 1..N+1) {
        foreach (i; 0..N) {
            if (i+k > N) break;
            foreach (j; 0..N) {
                int s;
                foreach (l; 0..k) {
                    s += MAP[i+l][j];
                }
                MEMO[i][j][k] = s;
            }
        }
    }
    auto DP = new int[](N^^2+1);
    foreach (k; 1..N+1) {
        foreach (i; 0..N) {
            if (i+k > N) break;
            foreach (j; 0..N) {
                int s;
                foreach (l; j..N) {
                    s += MEMO[i][l][k];
                    DP[k*(l-j+1)] = max(DP[k*(l-j+1)], s);
                }
            }
        }
    }

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto p = readln.chomp.to!int;
        int r;
        foreach (q; 0..p+1) r = max(r, DP[q]);
        writeln(r);
    }
}