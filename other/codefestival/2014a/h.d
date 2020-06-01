import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rc = readln.split.to!(int[]);
    auto R = rc[0];
    auto C = rc[1];

    auto M = new char[][R];
    foreach (i; 0..R) MAP[i] = readln.chomp.to!(char[]);

    int r;
    foreach (i; 0..R-1) foreach (j; 0..C-1) {
        if (M[i][j] == M[i+1][j+1] && M[i+1][j] == M[i][j+1]) {
            ++r;
            foreach (d; 1..250) {
                if (i-d < 0 || i+d >= R || j-d < 0 || i+d >= C) break;
                if (M[i-d][j-d] != M[i+d+1][j+d+1]) break;
                foreach ()
            }
        }
    }
}
