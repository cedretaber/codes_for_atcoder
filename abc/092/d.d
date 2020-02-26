import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];

    auto C = new char[][](100, 100);
    foreach (i; 0..50) C[i][] = '#';
    foreach (i; 50..100) C[i][] = '.';

    foreach (i; 0..A-1) {
        auto h = i/50 * 2;
        auto w = i%50 * 2;
        C[h][w] = '.';
    }
    foreach (i; 0..B-1) {
        auto h = 99 - i/50 * 2;
        auto w = i%50 * 2;
        C[h][w] = '#';
    }

    writeln("100 100");
    foreach (c; C) writeln(c);
}