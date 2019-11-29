import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import core.bitop;

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    auto D = nd[1];
    auto X = new uint[](D);
    foreach (i; 0..D) {
        foreach (j, c; readln.chomp) if (c == 'o') X[i] |= (1<<j);
    }
    int max_n;
    foreach (i; 0..D) {
        foreach (j; i+1..D) {
            max_n = max(max_n, popcnt(X[i] | X[j]));
        }
    }
    writeln(max_n);
}