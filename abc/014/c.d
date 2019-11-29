import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^6+2] AS, BS, CS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        ++AS[ab[0]];
        ++BS[ab[1]+1];
    }
    int r, s;
    foreach (i; 0..10^^6+1) {
        s = s + AS[i] - BS[i];
        r = max(r, s);
    }
    writeln(r);
}