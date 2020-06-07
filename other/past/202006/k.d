import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

class Cont
{
    int n;
    Cont prev, next;

    this(int n) {
        this.n = n;
    }
}

class Desk
{
    Cont first, last;
}

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    auto cs = new Cont[](N);
    foreach (i; 0..N) {
        cs[i] = new Cont(i);
    }

    auto ds = new Desk[](N);
    foreach (i; 0..N) {
        ds[i] = new Desk();
        ds[i].first = cs[i];
        ds[i].last = cs[i];
    }

    foreach (_; 0..Q) {
        auto ftx = readln.split.to!(int[]);
        auto f = ftx[0]-1;
        auto t = ftx[1]-1;
        auto x = ftx[2]-1;

        auto last = ds[f].last;
        if (cs[x].prev is null) {
            ds[f].first = null;
            ds[f].last = null;
        } else {
            ds[f].last = cs[x].prev;
            cs[x].prev.next = null;
        }

        if (ds[t].first is null) {
            ds[t].first = cs[x];
            cs[x].prev = null;
        } else {
            ds[t].last.next = cs[x];
            cs[x].prev = ds[t].last;
        }
        ds[t].last = last;
    }

    auto res = new int[](N);
    foreach (i; 0..N) {
        auto c = ds[i].first;
        while (c) {
            res[c.n] = i+1;
            c = c.next;
        }
    }

    foreach (r; res) writeln(r);
}