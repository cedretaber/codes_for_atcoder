import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto mk = readln.split.to!(int[]);
    auto M = mk[0];
    auto K = mk[1];
    if (K == 0) {
        int[] rs;
        foreach (i; 0..2^^M) {
            rs ~= i;
            rs ~= i;
        }
        writeln(rs.to!(string[]).join(" "));
        return;
    }
    if (K >= 2^^M) {
        writeln(-1);
        return;
    }
    uint x;
    foreach (i; 0..2^^M) if (i != K) x ^= i;
    if (x != K) {
        writeln(-1);
        return;
    }
    int[] rs;
    foreach (i; 0..2^^M) if (i != K) rs ~= i;
    rs ~= K;
    foreach_reverse (i; 0..2^^M) if (i != K) rs ~= i;
    rs ~= K;
    writeln(rs.to!(string[]).join(" "));
}