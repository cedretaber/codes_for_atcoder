import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias E = Tuple!(int, "from", int, "to", long, "c");

E[5000] T;
long[2500] CS;

void main()
{
    auto nmp = readln.split.to!(int[]);
    auto N = nmp[0];
    auto M = nmp[1];
    auto P = nmp[2].to!long;

    foreach (i; 0..M) {
        auto abc = readln.split.to!(int[]);
        T[i] = E(abc[0]-1, abc[1]-1, abc[2] - P);
    }

    foreach (i; 1..N) CS[i] = long.min / 2;

    foreach (i; 0..N) {
        foreach (j; 0..M) {
            auto e = T[j];
            if (CS[e.to] < CS[e.from] + e.c) {
                CS[e.to] = CS[e.from] + e.c;
            }
        }
    }

    auto r = CS[N-1];

    foreach (i; 0..N) {
        foreach (j; 0..M) {
            auto e = T[j];
            if (CS[e.to] < CS[e.from] + e.c) {
                CS[e.to] = CS[e.from] + e.c;
            }
        }
    }

    writeln(r == CS[N-1] ? max(0, r) : -1);
}