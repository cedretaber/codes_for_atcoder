import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto rs = new long[](N);
    auto cs = new long[](N);
    foreach (i; 0..N) {
        rs[i] = i;
        cs[i] = i;
    }
    bool f;

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto q = readln.split.to!(int[]);
        if (q[0] == 3) {
            f = !f;
            continue;
        }

        auto a = q[1]-1;
        auto b = q[2]-1;
        if (q[0] == 1) {
            if (!f) {
                swap(rs[a], rs[b]);
            } else {
                swap(cs[a], cs[b]);
            }
        } else if (q[0] == 2) {
            if (!f) {
                swap(cs[a], cs[b]);
            } else {
                swap(rs[a], rs[b]);
            }
        } else {
            writeln(f ? N * rs[b] + cs[a] : N * rs[a] + cs[b]);
        }
    }
}