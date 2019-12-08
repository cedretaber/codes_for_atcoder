import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!long;
    auto AS = readln.split.to!(ulong[]);
    long[61][] CS;
    CS.length = N;
    foreach_reverse (i; 0..N) {
        foreach (j; 0..61) {
            if (i != N-1) CS[i][j] = CS[i+1][j];
            if (AS[i] & (1L<<j)) ++CS[i][j];
        }
    }
    long r;
    foreach (i; 0..N-1) {
        auto a = AS[i];
        foreach (j; 0..61) {
            long x;
            if (a & (1L<<j)) {
                x = (((1L<<j) % P) * (N - i - 1 - CS[i+1][j])) % P;
            } else {
                x = (((1L<<j) % P) * CS[i+1][j]) % P;
            }
            r = (r + x) % P;
        }
    }
    writeln(r);
}