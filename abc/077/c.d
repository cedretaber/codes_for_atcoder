import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);
    auto CS = readln.split.to!(int[]);
    sort(AS);
    sort(BS);
    sort(CS);

    auto XS = new long[](N);
    long j;
    foreach (i, b; BS) {
        while (j < N && CS[j] <= b) ++j;
        XS[i] = N - j;
    }
    foreach_reverse (i; 1..N) XS[i-1] += XS[i];
    j = 0;
    long r;
    foreach (i, a; AS) {
        while (j < N && BS[j] <= a) ++j;
        r += (j == N ? 0 : XS[j]);
    }
    writeln(r);
}