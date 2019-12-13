import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    size_t i, j;
    int s, r;
    while (i < N) {
        s += as[i++];
        while (s >= N) {
            if (s == N) ++r;
            s -= as[j++];
        }
    }
    writeln(r);
}