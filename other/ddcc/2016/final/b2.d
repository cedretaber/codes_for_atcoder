import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    long X = nx[1];
    auto ts = readln.split.to!(int[]);
    auto as = readln.split.to!(long[]);
    auto T = new long[][10^^5+1];
    foreach (i; 0..N) {
        T[ts[i]] ~= as[i];
    }

    bool check(int max_t) {
        auto Q = heapify([-1L]);
        long x;
        foreach_reverse (t; 0..10^^5+1) {
            if (Q.front != -1 && t < max_t) {
                x += Q.front;
                Q.popFront();
            }
            foreach (a; T[t]) Q.insert(a);
        }
        return x >= X;
    }

    if (check(10^^5) == false) {
        writeln(-1);
        return;
    }

    int l, r = 10^^5;
    while (l+1 < r) {
        auto m = (l+r)/2;
        if (check(m)) {
            r = m;
        } else {
            l = m;
        }
    }
    writeln(r);
}