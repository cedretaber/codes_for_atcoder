import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto MAP = new char[][](H, W);
    foreach (i; 0..H) {
        foreach (j, c; readln.chomp) MAP[i][j] = c;
    }
    foreach (i; 0..H) foreach (j; 0..W) if (MAP[i][j] == '#') {
        bool ok;
        if (i > 0 && MAP[i-1][j] == '#') ok = true;
        if (i < H-1 && MAP[i+1][j] == '#') ok = true;
        if (j > 0 && MAP[i][j-1] == '#') ok = true;
        if (j < W-1 && MAP[i][j+1] == '#') ok = true;
        if (!ok) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}