import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

bool[101] L;

void main()
{
    auto nmx = readln.split.to!(int[]);
    auto N = nmx[0];
    auto M = nmx[1];
    auto X = nmx[2];
    foreach (a; readln.split.to!(int[])) L[a] = true;

    int a, b;
    foreach (i; 0..N+1) {
        if (L[i]) ++a;
        if (i == X) {
            b = a;
            a = 0;
        }
    }
    writeln(min(a, b));
}