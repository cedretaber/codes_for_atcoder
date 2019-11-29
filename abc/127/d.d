import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias BC = Tuple!(long, "b", long, "c");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto AS = readln.split.to!(long[]);
    sort!"a > b"(AS);

    BC[] BCS;
    BCS.length = M;
    foreach (ref bc; BCS) {
        auto l = readln.split.to!(long[]);
        bc = BC(l[0], l[1]);
    }
    sort!"a.c > b.c"(BCS);

    long r;
    int i, j;
    foreach (_; 0..N) {
        if (j < M && BCS[j].b <= 0) ++j;
        if (j == M || AS[i] > BCS[j].c) {
            r += AS[i++];
        } else {
            r += BCS[j].c;
            BCS[j].b -= 1;
        }
    }
    writeln(r);
}