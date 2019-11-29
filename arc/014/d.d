import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

template bsearch(alias fun) {

    import std.functional: unaryFun;
    alias f = unaryFun!fun;

    int bsearch(T)(T[] arr) {
        if (arr.empty) return -1;

        if (!f(arr[0])) return -1;

        if (f(arr[$-1])) return arr.length.to!int - 1;

        int l, r = arr.length.to!int - 1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (f(arr[m])) {
                l = m;
            } else {
                r = m;
            }
        }
        return l;
    }
}

long[10^^5] LS, MS, SS;

void main()
{
    auto anm = readln.split.to!(int[]);
    auto all = anm[0];
    long N = anm[1];
    auto M = anm[2];
    foreach (i; 0..N) {
        LS[i] = readln.chomp.to!long;
        if (i != 0) MS[i-1] = LS[i] - LS[i-1] - 1;
    }
    sort(MS[0..N-1]);
    foreach (i; 0..N-1) {
        if (i != 0) SS[i] = SS[i-1];
        SS[i] += MS[i];
    }

    foreach (_; 0..M) {
        auto xy = readln.split.to!(long[]);
        auto x = xy[0];
        auto y = xy[1];

        long r = N + min(LS[0] - 1, x) + min(all - LS[N-1], y);

        if (MS[0] >= x + y) {
            r += (x + y) * (N - 1);
        } else if (MS[N-2] <= x + y) {
            r += SS[N-2];
        } else {
            auto l = bsearch!(m => m <= x + y)(MS[0..N-1]);
            r += SS[l] + (x + y) * (N - l - 2);
        }

        writeln(r);
    }
}