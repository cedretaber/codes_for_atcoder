import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = new long[](10^^5+1);
    long S;
    foreach (a; readln.split.to!(long[])) {
        S += a;
        ++as[a];
    }
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto bc = readln.split.to!(int[]);
        auto B = bc[0];
        auto C = bc[1];
        S -= as[B] * B;
        S += as[B] * C;
        writeln(S);
        as[C] += as[B];
        as[B] = 0;
    }
}