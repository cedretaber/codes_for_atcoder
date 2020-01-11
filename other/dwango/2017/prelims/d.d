import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias X = Tuple!(int, "i", int, "x");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    int[] xs, ys;
    auto ix = new X[](N);

    foreach (i; 0..N) {
        auto xy = readln.split.to!(int[]):
        
    }
}