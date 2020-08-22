import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    char[][] CS;
    foreach (_; 0..H) CS ~= readln.chomp.to!(char[]);
    auto oo = new long[][](H, W);
    foreach (i; 0..H) foreach_reverse (j; 0..W) {
        if (j != W-1) oo[i][j] = oo[i][j+1];
        if (CS[i][j] == 'O') ++oo[i][j];
    }
    auto ii = new long[][](H, W);
    foreach (j; 0..W) foreach_reverse (i; 0..H) {
        if (i != H-1) ii[i][j] = ii[i+1][j];
        if (CS[i][j] == 'I') ++ii[i][j];
    }
    long r;
    foreach (i; 0..H) foreach (j; 0..W) if (CS[i][j] == 'J') {
        r += oo[i][j] * ii[i][j];
    }
    writeln(r);
}