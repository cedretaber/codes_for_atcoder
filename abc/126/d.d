import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Path = Tuple!(int, "to", int, "w");
alias SS = Tuple!(int, "cur", int, "c");

Path[][10^^5] PS;
int[10^^5] TS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N-1) {
        auto uvw = readln.split.to!(int[]);
        auto u = uvw[0]-1;
        auto v = uvw[1]-1;
        auto w = uvw[2]%2;
        PS[u] ~= Path(v, w);
        PS[v] ~= Path(u, w);
    }

    TS[0] = 1;
    SS[] Q = [SS(0, 1)];
    while (!Q.empty) {
        auto head = Q[0];
        Q = Q[1..$];
        foreach (next; PS[head.cur]) {
            if (TS[next.to]) continue;
            int c;
            if (next.w == 0) {
                c = head.c;
            } else if (head.c == 1) {
                c = 2;
            } else {
                c = 1;
            }
            TS[next.to] = c;
            Q ~= SS(next.to, c);
        }
    }

    foreach (i; 0..N) {
        writeln(TS[i] - 1);
    }
}