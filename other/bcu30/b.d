import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    char[][] B;
    B.length = 9;
    foreach (i; 0..9) B[i] = readln.chomp.to!(char[]);
    foreach (i; 0..9) {
        foreach (j; 0..9) {
            auto n = B[i][j];
            foreach (k; 0..9) {
                if ((i != k && B[k][j] == n) || (j != k && B[i][k] == n)) {
                    writeln("No");
                    return;
                }
                foreach (x; -2..3) {
                    foreach (y; -2..3) {
                        if (abs(x) == abs(y)) continue;
                        auto a = i + x;
                        auto b = j + y;
                        if (a < 0 || a >= 9 || b < 0 || b >= 9) continue;
                        if (B[a][b] == n) {
                            writeln("No");
                            return;
                        }
                    }
                }
            }
        }
    }
    writeln("Yes");
}