import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias E = Tuple!(int, int);

void main()
{
    auto s = readln.chomp;
    if (s[0] == '0' || s[$-2] == '0' || s[$-1] == '1') {
        writeln(-1);
        return;
    }
    auto n = s.length.to!int;
    foreach (i; 0..n/2) {
        if (s[i] != s[n-i-2]) {
            writeln(-1);
            return;
        }
    } 
    E[] t;
    t.length = n-1;
    int e = 2, last, ti, t_size, last_e;
    void add_node(int i) {
        auto o = e;
        foreach (_; 0..i-last-1) {
            t[ti++] = E(e, ++e);
        }
        if (last_e) t[ti++] = E(e, last_e);
        last_e = o;
        auto ee = e;
        foreach (_; 0..last-t_size) {
            t[ti++] = E(ee, ++e);
        }
        t_size = i;
        ++e;
    }
    foreach (int i; 0..n/2) {
        if (s[i] == '0' && s[i-1] == '1') {
            add_node(i);
        } else {
            if (i == 0 || s[i-1] == '0') last = i;
        }
    }
    if (s[n/2-1] == '1') add_node(n/2);
    t[ti++] = E(1, last_e);
    while (e <= n) {
        t[ti++] = E(1, e++);
    }

    foreach (x; t) {
        writefln("%d %d", x[0], x[1]);
    }
}