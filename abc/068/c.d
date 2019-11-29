import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int N, M;
int[][int] RS;
int[200000] IS;

void main()
{
    auto nm = readln.split.to!(int[]);
    N = nm[0];
    M = nm[1];

    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0] - 1;
        auto b = ab[1] - 1;
        RS[a] ~= b;
        RS[b] ~= a;
    }

    IS[0] = 1;
    foreach (i; 0..N) {
        if (IS[i] == 1 && i in RS) {
            foreach (j; RS[i]) {
                if (IS[j] == 0) IS[j] = i == 0 ? 1 : 2;
            }
        }
    }

    writeln( IS[N-1] == 2 ? "POSSIBLE" : "IMPOSSIBLE" );
}