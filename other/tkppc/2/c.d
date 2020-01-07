import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto hs = readln.split.to!(int[]);
    int i, j;
    while (i < N && hs[i] == 1) ++i;
    foreach (_; 0..K) {
        ++i;
        while (i < N && hs[i] == 1) ++i;
        if (i >= N) {
            writeln(N);
            return;
        }
    }
    auto maxh = i-j;
    while (j < N) {
        ++i;
        while (i < N && hs[i] == 1) ++i;
        ++j;
        if (hs[j-1] == 1) while (j < N && hs[j-1] == 1) ++j;
        maxh = max(maxh, i-j);
    }
    writeln(maxh);
}