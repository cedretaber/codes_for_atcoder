import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto B = new char[][N];
    foreach (i; 0..N) B[i] = readln.chomp.to!(char[]);
    int x, y;
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (B[j][i] == 'X') {
                x += j;
            }
            if (B[j][i] == 'Y') {
                y += N-j-1;
            }
        }
    }
    writeln(x > y ? "X" : x < y ? "Y" : "Impossible");
}