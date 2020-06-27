import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto N = readln.chomp.to!int;
    auto YS = new long[](N+1);
    YS[] = 1;
    YS[0] = 0;
    foreach (i; 2..N+1) {
        long k = 1;
        while (i*k <= N) {
            YS[i*k] += 1;
            k += 1;
        }
    }
    long r;
    foreach (i; 1..N+1) r += YS[i] * i;
    writeln(r);
}