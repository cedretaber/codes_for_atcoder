import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[30] CNT;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (_; 0..N) {
        auto as = readln.split.to!(int[]);
        foreach (n; as[1..$]) {
            ++CNT[n-1];
        }
    }

    int cnt;
    foreach (c; CNT) if (c == N) ++cnt;

    writeln(cnt);
}