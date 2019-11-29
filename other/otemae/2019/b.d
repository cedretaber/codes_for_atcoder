import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[2000] L;

void main()
{
    auto mnk = readln.split.to!(int[]);
    auto M = mnk[0];
    auto K = mnk[2];
    foreach (x; readln.split.to!(int[])) ++L[x-1];

    int max_r;
    foreach (i; 0..M) {
        int r = L[i];
        foreach (j; 1..K+1) {
            if ((i-j >= 0 && L[i-j]) || (i+j < M && L[i+j])) ++r;
        }
        max_r = max(max_r, r);
    }
    writeln(max_r);
}