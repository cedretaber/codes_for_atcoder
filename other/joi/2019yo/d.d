import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias T = Tuple!(int, "i", int, "a");

void main()
{
    auto N = readln.chomp.to!int;
    auto ts = new T[](N);
    int max_a;
    foreach (i, a; readln.split.to!(int[])) {
        ts[i] = T(i.to!int, a);
        max_a = max(max_a, a);
    }
    if (max_a == 0) {
        writeln(0);
        return;
    }
    sort!"a.a == b.a ? a.i < b.i : a.a < b.a"(ts);
    auto bs = new bool[](N);
    int s = 1, max_s, last = -1;
    foreach (t; ts) {
        if (last != t.a) max_s = max(max_s, s);
        if (t.i == 0) {
            if (bs[t.i+1]) --s;
        } else if (t.i == N-1) {
            if (bs[t.i-1]) --s;
        } else {
            if (bs[t.i-1] && bs[t.i+1]) --s;
            if (!bs[t.i-1] && !bs[t.i+1]) ++s;
        }
        bs[t.i] = true;
        last = t.a;
    }
    writeln(max_s);
}