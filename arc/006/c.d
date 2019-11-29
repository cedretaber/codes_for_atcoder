import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    int[] rs;
    foreach (_; 0..N) {
        auto w = readln.chomp.to!int;
        if (rs.empty) {
            rs ~= w;
            continue;
        }

        int i = -1;
        foreach (j, r; rs) {
            if (r >= w) {
                i = j.to!int;
                break;
            }
        }
        if (i < 0) {
            rs ~= w;
        } else {
            rs[i] = w;
        }
        sort(rs);
    }
    writeln(rs.length);
}