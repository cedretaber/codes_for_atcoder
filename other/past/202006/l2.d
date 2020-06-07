import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias P = Tuple!(int, "k", int, "t");

void main()
{
    auto N = readln.chomp.to!int;
    auto ks = new int[][N];
    P[] aa, bb;
    auto ii = new int[](N);
    ii[] = 1;
    foreach (i; 0..N) {
        auto tt = readln.split.to!(int[]);
        ks[i] = tt[1..$];
        aa ~= P(i, ks[i][0]);
        bb ~= P(i, ks[i][0]);
        if (tt[0] > 1) {
            bb ~= P(i, ks[i][1]);
        }
    }

    auto a1 = redBlackTree!"a.t > b.t"(aa);
    auto a2 = redBlackTree!"a.t > b.t"(bb);

    auto M = readln.chomp.to!int;
    foreach (a; readln.split) {
        auto x = a == "1" ? a1.front : a2.front;

        writeln(x.t);

        if (a1.removeKey(x) > 0 && ii[x.k] < ks[x.k].length) {
            a1.insert(P(x.k, ks[x.k][ii[x.k]]));
        }

        a2.removeKey(x);
        if (++ii[x.k] < ks[x.k].length) {
            if (ii[x.k] < ks[x.k].length) a2.insert(P(x.k, ks[x.k][ii[x.k]]));
        }
    }
}