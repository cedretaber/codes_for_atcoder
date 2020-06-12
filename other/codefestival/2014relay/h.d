import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias L = Tuple!(int, "t", int, "c");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[int] mm;
    foreach (_; 0..M) {
        auto m = readln.chomp.to!int;
        ++mm[m];
    }
    L[] ls;
    foreach (t, c; mm) ls ~= L(t, c);
    sort!"a.t < b.t"(ls);

    int max_c = ls[0].c;
    int c = max_c;
    size_t last;
    foreach (i, l; ls[1..$]) {
        while (ls[last].t < l.t - N) {
            c -= ls[last].c;
            ++last;
        }
        c += l.c;
        max_c = max(c, max_c);
    }
    writeln(max_c);
}