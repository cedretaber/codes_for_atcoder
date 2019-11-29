import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import std.container.rbtree;

long[10^^5] PtoN;

void main()
{
    auto N = readln.chomp.to!int;
    auto PS = readln.split.to!(long[]);
    foreach (i, p; PS) PtoN[p-1] = i.to!long+1;

    auto rbt = redBlackTree!long();
    long r;
    foreach_reverse (long n; 0..N) {
        auto c = PtoN[n];
        rbt.insert(c);

        long a = 0, b = 0, d = N+1, e = N+1;
        auto ls = rbt.lowerBound(c);
        if (!ls.empty) {
            b = ls.back();
            ls.popBack();
            if (!ls.empty) a = ls.back;
        }
        auto rs = rbt.upperBound(c);
        if (!rs.empty) {
            d = rs.front();
            rs.popFront();
            if (!rs.empty) e = rs.front;
        }

        r += ((b-a)*(d-c) + (e-d)*(c-b))*(n+1);
    }

    writeln(r);
}