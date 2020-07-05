import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];

    char[][] MAP;
    foreach (_; 0..H) MAP ~= readln.chomp.to!(char[]);

    int res;
    foreach (y; 0..1<<H) foreach (x; 0..1<<W) {
        int b;
        foreach (i; 0..H) foreach (j; 0..W) if (MAP[i][j] == '#' && (y & (1<<i)) && (x & (1<<j))) ++b;
        if (b == K) ++res;
    }
    writeln(res);
}