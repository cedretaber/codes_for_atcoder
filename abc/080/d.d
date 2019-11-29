import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias Prog = Tuple!(int, "c", int, "s", int, "t");

int N;
Prog[10^^5] PS;

void main()
{
    auto nc = readln.split.to!(int[]);
    N = nc[0];
    foreach (i; 0..N) {
        auto stc = readln.split.to!(int[]);
        PS[i] = Prog(stc[2], stc[0], stc[1]);
    }

    sort!"a.s < b.s"(PS[0..N]);

    Prog[] rs;
    foreach (p; PS[0..N]) {
        bool can;
        foreach (ref r; rs) {
            if (r.c == p.c && r.t == p.s) {
                can = true;
                r = p;
                break;
            }
            if (r.t < p.s) {
                can = true;
                r = p;
                break;
            }
        }
        if (!can) {
            rs ~= p;
        }
    }
    writeln(rs.length);
}