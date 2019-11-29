import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias Pair = Tuple!(int, int);

Pair[10^^5] MS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..M) {
        auto ab = readln.split.to!(int[]);
        MS[i] = Pair(ab[0]-1, ab[1]-1);
    }

    sort(MS[0..M]);

    int cnt, j, near = int.max;
    foreach (i; 0..N) {
        if (i == near) {
            ++cnt;
            near = int.max;
        }
        while (j < M && MS[j][0] == i) {
            near = min(near, MS[j][1]);
            ++j;
        }
    }
    writeln(cnt);
}
