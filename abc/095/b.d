import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];
    int min_m = int.max;
    foreach (_; 0..N) {
        auto m = readln.chomp.to!int;
        X -= m;
        min_m = min(min_m, m);
    }
    writeln(N + X/min_m);
}