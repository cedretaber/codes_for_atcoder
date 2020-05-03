import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    char[][] M;
    foreach (_; 0..N) {
        M ~= readln.chomp.to!(char[]);
    }
    foreach_reverse (i; 0..N-1) {
        foreach (j; 1..N*2-2) {
            if (M[i][j] == '#' && (M[i+1][j-1] == 'X' || M[i+1][j] == 'X' || M[i+1][j+1] == 'X')) {
                M[i][j] = 'X';
            }
        }
    }
    foreach (m; M) writeln(m);
}