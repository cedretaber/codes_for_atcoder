import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto Q = heapify([0]);
    int l, r;
    foreach (i; 0..N) {
        auto t = readln.chomp.to!int;
        if (i == 0) {
            l = t;
            r = t;
        } else {
            Q.insert(t-r-1);
            r = t;
        }
    }
    auto t = r-l+1;
    foreach (_; 1..K) {
        t -= Q.front;
        Q.popFront();
    }
    writeln(t);
}