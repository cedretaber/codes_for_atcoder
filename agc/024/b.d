import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[(10^^5)*2+1] PS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto p = readln.chomp.to!int;
        PS[p] = PS[p-1] + 1;
    }

    int max = 0;
    foreach (p; PS[0..N+1]) if (p > max) max = p;
    writeln(N - max);
}