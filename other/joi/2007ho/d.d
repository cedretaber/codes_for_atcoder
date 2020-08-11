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

    auto S = SList!int();
    int s_size;
    foreach (i, t; ts) if (t == 0) {
        S.insert(i.to!int);
        ++s_size;
    }
    bool any = s_size > 1;
    while (!S.empty) {
        auto i = S.front;
        S.removeFront();
        --s_size;
        writeln(i+1);
        foreach (j; G[i]) {
            --ts[j];
            if (ts[j] == 0) {
                S.insert(j);
                ++s_size;
            }
        }
        if (s_size > 1) {
            any = true;
        }
    }
    writeln(any ? 1 : 0);
}