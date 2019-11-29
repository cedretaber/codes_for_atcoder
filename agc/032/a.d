import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto bs = readln.split.to!(int[]);

    int[] solve(int[] as) {
        if (as.empty) {
            return [];
        } else {
            foreach_reverse (i, a; as) {
                if (a == i+1) return solve(as[0..i] ~ as[i+1..$]) ~ a;
            }
            return [-1];
        }
    }

    auto rs = solve(bs);
    if (rs[0] == -1) {
        writeln("-1");
    } else {
        foreach (r; rs) writeln(r);
    }
}