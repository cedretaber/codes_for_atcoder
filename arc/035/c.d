import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto R = new long[][](N, N);
    foreach (ref r; R) r[] = long.max / 3;
    foreach (i; 0..N) R[i][i] = 0;
    foreach (_; 0..M) {
        auto xyz = readln.split.to!(int[]);
        auto x = xyz[0]-1;
        auto y = xyz[1]-1;
        long z = xyz[2];
        R[x][y] = min(R[x][y], z);
        R[y][x] = min(R[y][x], z);
    }

    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) {
        if (R[i][j] > R[i][k] + R[k][j]) {
            R[i][j] = R[i][k] + R[k][j];
        }
    }

    long S;
    foreach (i; 0..N) foreach (j; 0..N) S += R[i][j];

    auto K = readln.chomp.to!int;
    foreach (_; 0..K) {
        auto xyz = readln.split.to!(int[]);
        auto x = xyz[0]-1;
        auto y = xyz[1]-1;
        long z = xyz[2];

        if (R[x][y] > z) {
            S -= (R[x][y] - z) * 2;
            R[x][y] = z;
            R[y][x] = z;
            foreach (i; 0..N) foreach (j; 0..N) {
                if (R[i][j] > R[i][x] + R[x][y] + R[y][j]) {
                    S -= (R[i][j] - (R[i][x] + R[x][y] + R[y][j])) * 2;
                    R[i][j] = R[i][x] + R[x][y] + R[y][j];
                    R[j][i] = R[i][x] + R[x][y] + R[y][j];
                }
                if (R[i][j] > R[i][y] + R[y][x] + R[x][j]) {
                    S -= (R[i][j] - (R[i][y] + R[y][x] + R[x][j])) * 2;
                    R[i][j] = R[i][y] + R[y][x] + R[x][j];
                    R[j][i] = R[i][y] + R[y][x] + R[x][j];
                }
            }
        }

        writeln(S/2);
    }
}