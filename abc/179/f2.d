import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    long r = (N.to!long-2)^^2;

    auto lms = new int[](N+1);
    int min_w = N;
    auto bms = new int[](N+1);
    int min_v = N;
    foreach (_; 0..Q) {
        auto q = readln.split.to!(int[]);
        auto x = q[1];
        if (q[0] == 1) {
            if (x < min_w) {
                while (min_w > x) {
                    lms[--min_w] = min_v - 2;
                }
            }
            r -= lms[x];
        } else {
            if (x < min_v) {
                while (min_v > x) {
                    bms[--min_v] = min_w - 2;
                }
            }
            r -= bms[x];
        }
    }
    writeln(r);
}