import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto MAP = new int[][](H, W);
    foreach (ref m; MAP) m[] = int.max/3;
    foreach (i; 0..H) foreach (j, c; readln.chomp) if (c == 'c') MAP[i][j] = 0;
    foreach (i; 0..H) foreach (j; 1..W) MAP[i][j] = min(MAP[i][j], MAP[i][j-1] + 1);
    foreach (i; 0..H) foreach (j; 0..W) if (MAP[i][j] >= 1000) MAP[i][j] = -1;
    foreach (i; 0..H) writeln(MAP[i].to!(string[]).join(" "));
}