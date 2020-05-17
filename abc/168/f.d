import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias H = Tuple!(long, "x1", long, "x2", long, "y");
alias V = Tuple!(long, "x", long, "y1", long, "y2");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    H[] ths;
    foreach (_; 0..N) {
        auto abc = readln.split.to!(long[]);
        ths ~= H(abc[0], abc[1], abc[2]);
    }
    V[] tvs;
    foreach (_; 0..M) {
        auto def = readln.split.to!(long[]);
        tvs ~= V(def[0], def[1], def[2]);
    }

    bool[] memo;
    memo.length = N;
    H[] hs;
    foreach (j, h; ths) if (!memo[j]) {
        foreach (i, hh; ths) {
            if (!memo[i] && h.y == hh.y && (h.x2 >= hh.x1 || h.x1 <= hh.x2)) {
                memo[i] = true;
                h = H(min(h.x1, hh.x1), max(h.x2, hh.x2), h.y);
            }
        }
        memo[j] = true;
        hs ~= h;
    }
    memo.length = M;
    memo[] = false;
    V[] vs;
    foreach (j, v; tvs) if (!memo[j]) {
        foreach (i, vv; tvs) {
            if (!memo[i] && v.x == vv.x && (v.y1 >= vv.y1 || v.y1 <= vv.y2)) {
                memo[i] = true;
                v = V(v.x, min(v.y1, vv.y1), max(v.y2, vv.y2));
            }
        }
        memo[j] = true;
        vs ~= v;
    }

    writeln(hs);
    writeln(vs);
}