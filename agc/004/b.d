import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(long[]);
    auto N = nx[0];
    auto x = nx[1];
    auto as = readln.split.to!(long[]);
    long[] bs;
    foreach (a; as) bs ~= a;

    long min_s = long.max;
    foreach (k; 0..N) {
        long s;
        long[] cs;
        if (k == 0) {
            cs = bs;
        } else {
            cs.length = N;
            foreach (i; 0..N) {
                cs[(i+1)%N] = min(bs[(i+1)%N], bs[i]);
            }
        }
        bs = cs;
        foreach (i; 0..N) {
            s += bs[i];
        }
        min_s = min(min_s, s + k*x);
    }
    writeln(min_s);
}