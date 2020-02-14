import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

alias OP = Tuple!(int, "x", int, "y");

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);

    OP[] lr, rl;
    foreach (i; 0..N-1) lr ~= OP(i, i+1);
    foreach_reverse (i; 0..N-1) rl ~= OP(i+1, i);

    long max_a = long.min, min_a = long.max;
    int max_i, min_i;
    foreach (i, a; as) {
        if (a > max_a) {
            max_a = a;
            max_i = i.to!int;
        }
        if (a < min_a) {
            min_a = a;
            min_i = i.to!int;
        }
    }
    if (max_a == min_a) {
        writeln(0);
        return;
    }

    OP[] res;
    if (max_a <= 0) {
        res = rl;
    } else if (min_a >= 0) {
        res = lr;
    } else if (abs(max_a) > abs(min_a)) {
        foreach (i; 0..N) if (i != max_i) res ~= OP(max_i, i);
        res ~= lr;
    } else {
        foreach (i; 0..N) if (i != min_i) res ~= OP(min_i, i);
        res ~= rl;
    }
    writeln(res.length);
    foreach (r; res) writefln("%d %d", r.x+1, r.y+1);
}