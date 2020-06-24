import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.traits;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto as = readln.split.to!(long[]);
    auto G = new int[][N];
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0];
        auto y = xy[1];
        G[x] ~= y;
        G[y] ~= x;
    }
    auto F = new bool[](N);
    long[][] xs;
    foreach (i; 0..N) {
        if (F[i]) continue;
        F[i] = true;
        xs ~= [as[i]];
        void walk(int i) {
            foreach (j; G[i]) if (!F[j]) {
                xs[$-1] ~= as[j];
                F[j] = true;
                walk(j);
            }
        }
        walk(i);
    }
    auto len = xs.length;
    if (len == 1) {
        writeln(0);
        return;
    }
    long r;
    auto Q = heapify!"a > b"([long.max]);
    foreach (ref x; xs) {
        sort(x);
        r += x[0];
        foreach (a; x[1..$]) Q.insert(a);
    }
    foreach (_; 0..(len-1)*2 - len) {
        if (Q.front == long.max) {
            writeln("Impossible");
            return;
        }
        r += Q.front;
        Q.removeFront();
    }
    writeln(r);
}