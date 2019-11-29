import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[3][2] BS;
int[2][3] CS;

int[2] solve(int t, int[3][3] bd)
{
    if (t == 9) {
        int b, c;
        foreach (int ij; 0..9) {
            int i = ij/3;
            int j = ij%3;
            if (i+1 < 3) {
                if(bd[i][j] == bd[i+1][j]) {
                    b += BS[i][j];
                } else {
                    c += BS[i][j];
                }
            }
            if (j+1 < 3) {
                if (bd[i][j] == bd[i][j+1]) {
                    b += CS[i][j];
                } else {
                    c += CS[i][j];
                }
            }
        }
        return [b, c];
    } else {
        auto m = t%2+1;
        int max_b = -1, max_c = -1;
        foreach (int ij; 0..9) {
            auto i = ij/3;
            auto j = ij%3;
            if (bd[i][j]) continue;
            bd[i][j] = m;
            auto r = solve(t+1, bd);
            if ((m == 1 && r[0] > max_b) || (m == 2 && r[1] > max_c)) {
                max_b = r[0];
                max_c = r[1];
            }
            bd[i][j] = 0;
        }
        return [max_b, max_c];
    }
}

void main()
{
    foreach (i, b; readln.split.to!(int[])) BS[0][i] = b;
    foreach (i, b; readln.split.to!(int[])) BS[1][i] = b;
    foreach (i, c; readln.split.to!(int[])) CS[0][i] = c;
    foreach (i, c; readln.split.to!(int[])) CS[1][i] = c;
    foreach (i, c; readln.split.to!(int[])) CS[2][i] = c;

    auto r = solve(0, [[0, 0, 0], [0, 0, 0], [0, 0, 0]]);
    writeln(r[0]);
    writeln(r[1]);
}