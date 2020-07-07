import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum MAX = 10^^5+1;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto ps = new int[][MAX];
    foreach (_; 0..N) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0];
        auto y = xy[1];
        ps[x] ~= y;
    }
    int[] as;
    foreach (_; 0..M) as ~= readln.chomp.to!int;
    sort(as);
    as ~= MAX;
    auto qs = heapify!"a > b"([MAX]);
    int res;
    foreach (i; 0..MAX) {
        foreach (p; ps[i]) qs.insert(p);
        while (as[0] == i && qs.front != MAX) {
            ++res;
            as = as[1..$];
            qs.removeFront();
        }
        while (as[0] == i) as = as[1..$];
        while (qs.front == i) qs.removeFront();
    }
    writeln(res);
}