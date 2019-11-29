import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[3*10^^5] AS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    foreach (i; 0..N) AS[i] = readln.chomp.to!int;
    if (K == 1) {
        writeln(N);
        return;
    }
    size_t i, j = 1;
    int r;
    while (j < N) {
        if (AS[j] > AS[j-1]) {
            if (j-i+1 >= K) ++r;
            ++j;
        } else {
            i = j;
            j = i+1;
        }
    }
    writeln(r);
}