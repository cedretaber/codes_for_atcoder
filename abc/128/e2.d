import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias K = Tuple!(long, "t", long, "x", char, "d");

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    K[] ks;
    foreach (_; 0..N) {
        auto stx = readln.split.to!(long[]);
        auto S = stx[0];
        auto T = stx[1];
        auto X = stx[2];
        ks ~= K(S-X, X, 's');
        ks ~= K(T-X, X, 't');
    }
    sort!"a.t < b.t"(ks);
    auto rbt = redBlackTree!true(long.max);
    foreach (_; 0..Q) {
        auto D = readln.chomp.to!int;
        while (!ks.empty && ks[0].t <= D) {
            if (ks[0].d == 's') {
                rbt.insert(ks[0].x);
            } else {
                rbt.removeKey(ks[0].x);
            }
            ks = ks[1..$];
        }
        auto d = rbt.front;
        writeln(d == long.max ? -1 : d);
    }
}