import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nq = readln.split.to!(long[]);
    auto n = nq[0];
    auto q = nq[1];
    long[] as;
    foreach (_; 0..q) as ~= readln.chomp.to!long;

    long r;
    void count(long i, long x) {
        if (x > n) return;
        if (i == -1) {
            ++r;
            return;
        }
        count(i-1, x*as[i]);
        if (x/as[i] && x%as[i] == 0) return;
        count(i-1, x);
    }
    foreach (i; 0..q) count(i-1, as[i]);
    writeln(r + 1);
}