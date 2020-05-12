import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias L = Tuple!(int, "s", int, "e");

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int[] ns;
    foreach (_; 0..K) ns ~= readln.chomp.to!int;
    sort(ns);
    auto white = ns[0] == 0;
    if (white) ns = ns[1..$];
    L[] ls;
    auto x = L(ns[0], ns[0]);
    foreach (n; ns[1..$]) {
        if (n == x.e + 1) {
            x.e = n;
        } else {
            ls ~= x;
            x = L(n, n);
        }
    }
    ls ~= x;
    int max_l;
    foreach (i, l; ls) {
        if (i && ls[i-1].e + 2 == l.s && white) {
            max_l = max(max_l, ls[i-1].e - ls[i-1].s + l.e - l.s + 3);
        }
        max_l = max(max_l, l.e - l.s + 1 + (white ? 1 : 0));
    }
    writeln(max_l);
}