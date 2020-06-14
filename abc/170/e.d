import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    auto kds = new RedBlackTree!(int, "a > b", true)[](2*10^^5);
    foreach (ref kd; kds) kd = new RedBlackTree!(int, "a > b", true)([-1]);
    int[] AS, BS;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0];
        auto B = ab[1] - 1;
        AS ~= A;
        BS ~= B;
        kds[B].insert(A);
    }
    int[] max_rs;
    foreach (i; 0..2*10^^5) if (kds[i].front != -1) max_rs ~= kds[i].front;
    auto rs = redBlackTree!true(max_rs);

    foreach (_; 0..Q) {
        auto cd = readln.split.to!(int[]);
        auto C = cd[0]-1;
        auto D = cd[1]-1;

        auto p = BS[C];
        BS[C] = D;

        auto r = AS[C];

        rs.removeKey(kds[p].front);
        if (kds[D].front != -1) rs.removeKey(kds[D].front);

        kds[p].removeKey(r);
        if (kds[p].front != -1) rs.insert(kds[p].front);
        kds[D].insert(r);
        rs.insert(kds[D].front);

        writeln(rs.front);
    }
}