import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto hs = readln.split.to!(int[]);

    int solve(int[] lr) {
        if (lr.empty) return 0;

        auto m = int.max;
        foreach (n; lr) m = min(m, n);

        int r = m;
        size_t i;
        foreach (j, ref n; lr) {
            n -= m;
            if (!n) {
                r += solve(lr[i..j]);
                i = j+1;
            }
        }
        return r + (lr[$-1] == 0 ? 0 : solve(lr[i..$]));
    }
    writeln(solve(hs));
}