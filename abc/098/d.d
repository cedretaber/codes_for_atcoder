import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(ulong[]);
    ulong x;
    size_t i, j;
    long r;
    while (j < N) {
        while (i < N && x&AS[j]) {
            x ^= AS[i++];
        }
        r += j-i+1;
        x |= AS[j++];
    }
    writeln(r);
}