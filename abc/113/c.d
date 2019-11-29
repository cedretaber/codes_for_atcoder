import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias PY = Tuple!(int, "i", int, "p", int, "y", string, "n");

PY[10^^5] CS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..M) {
        auto py = readln.split.to!(int[]);
        CS[i] = PY(i, py[0], py[1], "");
    }

    sort!"a.p == b.p ? a.y < b.y : a.p < b.p"(CS[0..M]);

    int p, c;
    foreach (i, ref py; CS[0..M]) {
        if (py.p != p) {
            p = py.p;
            c = 0;
        }
        py.n = format("%06d%06d", py.p, ++c);
    }
    sort!"a.i < b.i"(CS[0..M]);
    foreach (cs; CS[0..M]) writeln(cs.n);
}