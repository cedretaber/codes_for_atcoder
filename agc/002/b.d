import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

bool[10^^5] PS;
int[10^^5] BS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    PS[0] = true;
    foreach (i; 0..N) BS[i] = 1;
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0]-1;
        auto y = xy[1]-1;
        --BS[x];
        ++BS[y];
        if (PS[x]) PS[y] = true;
        if (BS[x] == 0) PS[x] = false;
    }
    int r;
    foreach (i; 0..N) if (BS[i] > 0 && PS[i]) ++r;
    writeln(r);
}