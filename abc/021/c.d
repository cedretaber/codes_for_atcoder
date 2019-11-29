import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][100] MAP;

enum P = 10^^9+7L;

void main()
{
    auto N = readln.chomp.to!int;
    auto ab = readln.split.to!(int[]);
    auto a = ab[0]-1;
    auto b = ab[1]-1;
    auto M = readln.chomp.to!int;
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0]-1;
        auto y = xy[1]-1;
        MAP[x] ~= y;
        MAP[y] ~= x;
    }
    long[] CS;
    CS.length = N;
    CS[a] = 1;
    while (CS[b] == 0) {
        long[] buf;
        buf.length = N;
        foreach (i, ns; MAP) {
            foreach (n; ns) buf[n] += (CS[n] + CS[i]) % P;
        }
        CS = buf;
    }
    writeln(CS[b]);
}