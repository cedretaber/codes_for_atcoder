import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "c", int, "n");

void main()
{
    auto N = readln.chomp.to!int;
    P[] ps;
    {
        auto p = P(-1, 0);
        foreach (_; 0..N) {
            auto c = readln.chomp.to!int;
            if (p.c != c) {
                if (p.c != -1) ps ~= p;
                p = P(c, 1);
            } else {
                p.n += 1;
            }
        }
        ps ~= p;

        if (ps.length == 1) {
            writeln(p.n);
            return;
        }
    }

    int resolve(int l, int r) {
        int n;
        while (l >= 0 && r < ps.length) {
            if (ps[l].c != ps[r].c) break;
            if (ps[l].n + ps[r].n < 4) break;
            n += ps[l].n + ps[r].n;
            --l;
            ++r;
        }
        return n;
    }

    int max_r;
    foreach (ii, p; ps) {
        auto i = ii.to!int;
        if (p.n == 1) {
            if (i != 0 && i != ps.length-1 && ps[i-1].c == ps[i+1].c && ps[i-1].n + ps[i+1].n + 1 >= 4) {
                max_r = max(max_r, ps[i-1].n + ps[i+1].n + 1 + resolve(i-2, i+2));
            }
            if (i != 0 && ps[i-1].n == 3) {
                max_r = max(max_r, 4 + resolve(i-2, i+1));
            }
            if (i != ps.length-1 && ps[i+1].n == 3) {
                max_r = max(max_r, 4 + resolve(i-1, i+2));
            }
        } else {
            if (i != 0 && ps[i-1].n == 3) {
                int r = 4;
                if (i >= 2 && ps[i-2].c == p.c && ps[i-2].n + p.n > 4) {
                    r += ps[i-2].n + p.n - 1 + resolve(i-3, i+1);
                }
                max_r = max(max_r, r);
            }
            if (i != ps.length-1 && ps[i+1].n == 3) {
                int r = 4;
                if (i < ps.length-2 && p.c == ps[i+2].c && p.n + ps[i+2].n > 4) {
                    r += p.n + ps[i+2].n - 1 + resolve(i-1, i+3);
                }
                max_r = max(max_r, r);
            }
        }
    }
    writeln(N - max_r);
}