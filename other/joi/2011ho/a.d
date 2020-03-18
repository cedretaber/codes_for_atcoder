import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto mn = readln.split.to!(int[]);
    auto M = mn[0];
    auto N = mn[1];
    auto K = readln.chomp.to!int;
    auto JOI = new int[][][](3, M+1, N+1);
    foreach (i; 0..M) {
        foreach (j, c; readln.chomp) {
            switch (c) {
                case 'J': ++JOI[0][i+1][j+1]; break;
                case 'O': ++JOI[1][i+1][j+1]; break;
                case 'I': ++JOI[2][i+1][j+1]; break;
                default:
            }
            
            foreach (k; 0..3) {
                JOI[k][i+1][j+1] += JOI[k][i][j+1] + JOI[k][i+1][j] - JOI[k][i][j];
            }
        }
    }
    int[3] r;
    foreach (_; 0..K) {
        auto abcd = readln.split.to!(int[]);
        auto a = abcd[0]-1, b = abcd[1]-1, c = abcd[2], d = abcd[3];
        foreach (i; 0..3) r[i] = JOI[i][c][d] - JOI[i][c][b] - JOI[i][a][d] + JOI[i][a][b];
        writeln(r[0], " ", r[1], " ", r[2]);
    }
}