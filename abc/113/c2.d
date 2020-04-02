import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias C = Tuple!(int, "i", int, "p", int, "y");
alias N = Tuple!(int , "i", int, "p", int, "c");

void main()
{
    auto M = readln.split.to!(int[])[1];
    C[] cs;
    foreach (i; 0..M) {
        auto py = readln.split.to!(int[]);
        cs ~= C(i, py[0], py[1]);
    }
    sort!"a.p == b.p ? a.y < b.y : a.p < b.p"(cs);
    N[] ns;
    foreach (ccs; cs.chunkBy!"a.p") {
        int i;
        foreach (c; ccs[1]) {
            ns ~= N(c.i, c.p, ++i);
        }
    }
    sort!"a.i < b.i"(ns);
    foreach (n; ns) {
        writefln("%06d%06d", n.p, n.c);
    }
}