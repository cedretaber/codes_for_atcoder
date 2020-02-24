import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    writeln(N == 1 && M == 1 ? 1 : N == 1 ? M-2 : M == 1 ? N-2 : (N-2) * (M-2));
}