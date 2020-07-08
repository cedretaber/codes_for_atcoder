import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias R = Tuple!(int[], "cs", int, "i");

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto cs = new int[][](N, 26);
    foreach (i, c; readln.chomp) {
        if (i) foreach (j; 0..26) cs[i][j] = cs[i-1][j];
        ++cs[i][c - 'a'];
    }
    auto rs = [R(cs[K-1][].dup, 0)];
    foreach (i; K..N) {
        int[26] ds;
        ds[] += cs[i][];
        ds[] -= cs[i-K][];
        rs ~= R(ds[].dup, i-K+1);
    }
    sort(rs);
    for (int i; i < rs.length-1; ++i) {
        int j = i+1;
        if (rs[i].cs != rs[j].cs) {
            continue;
        } else {
            ++j;
        }
        while (j < rs.length && rs[i].cs == rs[j].cs) ++j;
        --j;
        if (rs[j].i - rs[i].i >= K) {
            writeln("YES");
            return;
        }
        i = j;
    }
    writeln("NO");
}