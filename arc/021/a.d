import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    int[][] B;
    B.length = 4;
    foreach (i; 0..4) B[i] = readln.split.to!(int[]);
    foreach (i; 0..4) {
        foreach (j; 0..4) {
            if ((i+1 < 4 && B[i][j] == B[i+1][j]) || (j+1 < 4 && B[i][j] == B[i][j+1])) {
                writeln("CONTINUE");
                return;
            }
        }
    }
    writeln("GAMEOVER");
}