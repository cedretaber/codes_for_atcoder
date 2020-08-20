import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.bitop;

alias H = Tuple!(int, "r", string, "s");

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;

    long[H] ls, rs;
    foreach (b; 0..(1<<N)) {
        auto ll = new char[](N);
        auto rr = new char[](N);
        int j, k = N-1, l, m = N-1;
        foreach (i; 0..N) {
            if (b & (1<<i)) {
                ll[j++] = S[i];
                rr[m--] = S[2*N-i-1];
            } else {
                ll[k--] = S[i];
                rr[l++] = S[2*N-i-1];
            }
        }
        auto r = popcnt(b);
        ++ls[H(r, ll.to!string)];
        ++rs[H(r, rr.to!string)];
    }
    long r;
    foreach (k, v; rs) {
        auto l = H(N - k.r, k.s);
        if (l in ls) r += v * ls[l];
    }
    writeln(r);
}