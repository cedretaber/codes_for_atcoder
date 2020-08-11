import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto M = readln.chomp.to!int;
    auto G = new int[][N];
    auto ts = new int[](N);
    foreach (_; 0..M) {
        auto ij = readln.split.to!(int[]);
        auto i = ij[0]-1;
        auto j = ij[1]-1;
        G[i] ~= j;
        ++ts[j];
    }

    int[] S;
    foreach (i, t; ts) if (t == 0) {
        S ~= i.to!int;
    }
    bool any = S.length > 1;
    while (!S.empty) {
        auto i = S[0];
        S = S[1..$];
        writeln(i+1);
        foreach (j; G[i]) {
            --ts[j];
            if (ts[j] == 0) S ~= j;
        }
        if (S.length > 1) any = true;
    }
    writeln(any ? 1 : 0);
}