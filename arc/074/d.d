import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import std.container : heapify;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);

    long[] lres, rres;
    lres.length = N+1;
    rres.length = N+1;

    auto ls = as[0..N].dup;
    sort!"a < b"(ls);
    foreach (l; ls) lres[0] += l;
    auto lq = heapify!"a > b"(ls, ls.length);

    auto rs = as[2*N..$].dup;
    sort!"a > b"(rs);
    foreach (r; rs) rres[N] += r;
    auto rq = heapify!"a < b"(rs, rs.length);

    foreach (i; 1..N+1) {
        auto l = as[N+i-1];
        lres[i] += lres[i-1] + l;
        if (l < lq.front) {
            lres[i] -= l;
        } else {
            lres[i] -= lq.front;
            lq.replaceFront(l);
        }

        auto r = as[2*N-i];
        rres[N-i] += rres[N-i+1] + r;
        if (r > rq.front) {
            rres[N-i] -= r;
        } else {
            rres[N-i] -= rq.front;
            rq.replaceFront(r);

        }
    }

    long max_r = long.min;
    foreach (i; 0..N+1) {
        max_r = max(max_r, lres[i] - rres[i]);
    }

    writeln(max_r);
}