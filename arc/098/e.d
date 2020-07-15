import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nkq = readln.split.to!(int[]);
    auto N = nkq[0];
    auto K = nkq[1];
    auto Q = nkq[2];
    auto AS = readln.split.to!(int[]);

    auto res = long.max;
    foreach (x; AS) {
        auto as = AS.dup ~ 0;
        size_t i;
        long[] cs;
        foreach (j, a; as) {
            if (a < x) {
                if (j-i >= K) {
                    sort(as[i..j]);
                    foreach (k; i..j-K+1) cs ~= as[k];
                }
                i = j+1;
            }
        }
        if (cs.length >= Q) {
            sort(cs);
            res = min(res, cs[Q-1] - x);
        }
    }
    writeln(res);
}