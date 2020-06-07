import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias P = Tuple!(int, "k", int, "i", int, "t");

void main()
{
    auto N = readln.chomp.to!int;
    auto ks = new int[][N];
    P[] aa, bb;
    auto i1 = new int[](N);
    auto i2 = new int[](N);
    foreach (i; 0..N) {
        auto tt = readln.split.to!(int[]);
        ks[i] ~= tt[1..$];
        aa ~= P(i, 0, ks[i][0]);
        bb ~= P(i, 0, ks[i][0]);
        i1[i] = 0;
        if (tt[0] > 1) {
            bb ~= P(i, 1, ks[i][1]);
            i2[i] = 1;
        } else {
            i2[i] = -1;
        }
    }

    auto a1 = heapify!"a.t < b.t"(aa);
    auto a2 = heapify!"a.t < b.t"(bb);

    auto M = readln.chomp.to!int;
    foreach (a; readln.split) {
        if (a == "1") {
            for (;;) {
                auto p = a1.front;
                a1.popFront();
                if (i1[p.k] != p.i) continue;

                writeln(p.t);
                i1[p.k] = i2[p.k];
                if (i1[p.k] == -1) break;
                a1.insert(P(p.k, i1[p.k], ks[p.k][i1[p.k]]));

                i2[p.k] += 1;
                if (i2[p.k] == ks[p.k].length) {
                    i2[p.k] = -1;
                    break;
                }
                a2.insert(P(p.k, i2[p.k], ks[p.k][i2[p.k]]));

                break;
            }
        } else {
            for (;;) {
                auto p = a2.front;
                a2.popFront();
                if (i1[p.k] == p.i) {
                    writeln(p.t);

                    i1[p.k] = i2[p.k];
                    if (i1[p.k] == -1) break;
                    a1.insert(P(p.k, i1[p.k], ks[p.k][i1[p.k]]));

                    i2[p.k] += 1;
                    if (i2[p.k] == ks[p.k].length) {
                        i2[p.k] = -1;
                        break;
                    }
                    a2.insert(P(p.k, i2[p.k], ks[p.k][i2[p.k]]));
                    break;
                } else if (i2[p.k] == p.i) {
                    writeln(p.t);

                    i2[p.k] += 1;
                    if (i2[p.k] == ks[p.k].length) {
                        i2[p.k] = -1;
                        break;
                    }
                    a2.insert(P(p.k, i2[p.k], ks[p.k][i2[p.k]]));
                    break;
                }
            }
        }
    }
}