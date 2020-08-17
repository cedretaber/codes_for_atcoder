import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto T = new int[][N];
    auto as = new int[](N);
    foreach (i; 0..N) {
        auto sa = readln.split.to!(int[]);
        auto s = sa[0]-1;
        if (s >= 0) {
            T[i] ~= s;
            T[s] ~= i;
        }
        auto a = sa[1];
        as[i] = a;
    }

    auto rs = new int[](N);
    int walk(int i, int p) {
        int s;
        foreach (j; T[i]) if (j != p) {
            auto r = walk(j, i);
            if (r > 0) s += r;
        }
        rs[i] = s + as[i];
        return rs[i];
    }
    walk(0, -1);
    writeln(rs.maxElement());
}