import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias LI = Tuple!(bool, "f", int, "l", long, "i");

int[10^^5+1] AMD;
LI[10^^5+1] LS;
int[][] LL;

void main()
{
    foreach (int i, ref e; AMD) e = i;

    auto nmd = readln.split.to!(int[]);
    auto N = nmd[0];
    auto M = nmd[1];
    auto D = nmd[2].to!long;

    foreach (a; readln.split.to!(int[]).reverse) swap(AMD[a], AMD[a+1]);

    foreach (i; 1..N+1) {
        if (LS[i].f) continue;
        auto l = LL.length.to!int;
        int[] ll = [i];
        LS[i] = LI(true, l, 0L);
        auto nxt = AMD[i];
        while (nxt != i) {
            LS[nxt] = LI(true, l, ll.length.to!long);
            ll ~= nxt;
            nxt = AMD[nxt];
        }
        LL ~= ll;
    }

    foreach (i; 1..N+1) {
        auto li = LS[i];
        writeln(LL[li.l][(li.i + D) % LL[li.l].length]);
    }
}