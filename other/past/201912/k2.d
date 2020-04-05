import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii, core.bitop;

void main()
{
    auto N = readln.chomp.to!int;
    int[][] T;
    T.length = N;
    int top;
    foreach (i; 0..N) {
        auto p = readln.chomp.to!int;
        if (p == -1) {
            top = i;
        } else {
            T[p-1] ~= i;
        }
    }
    auto ls = new int[](N);
    auto rs = new int[](N);
    int idx;
    void walk(int i) {
        ls[i] = idx++;
        foreach (j; T[i]) walk(j);
        rs[i] = idx;
    }
    walk(top);

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        writeln(ls[b] < ls[a] && rs[b] >= rs[a] ? "Yes" : "No");
    }
}