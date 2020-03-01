import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto AS = new int[][](3, 3);
    foreach (i; 0..3) foreach (j, a; readln.split.to!(int[])) AS[i][j] = a;
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto b = readln.chomp.to!int;
        foreach (i; 0..9) if (AS[i/3][i%3] == b) AS[i/3][i%3] = -1;
    }

    foreach (i; 0..3) {
        bool ok = true;
        foreach (j; 0..3) if (AS[i][j] != -1) ok = false;
        if (ok) {
            writeln("Yes");
            return;
        }
        ok = true;
        foreach (j; 0..3) if (AS[j][i] != -1) ok = false;
        if (ok) {
            writeln("Yes");
            return;
        }
    }

    if (
        (AS[0][0] == -1 && AS[1][1] == -1 && AS[2][2] == -1) ||
        (AS[0][2] == -1 && AS[1][1] == -1 && AS[2][0] == -1)
    ) {
        writeln("Yes");
        return;
    }

    writeln("No");
}