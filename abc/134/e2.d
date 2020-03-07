import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] AS;
    foreach (_; 0..N) AS ~= readln.chomp.to!int;

    int[] cs;
    foreach (a; AS) {
        if (cs.empty || cs[$-1] >= a) {
            cs ~= a;
            continue;
        } else if (cs[0] < a) {
            cs[0] = a;
            continue;
        }

        size_t l, r = cs.length-1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (cs[m] < a) {
                r = m;
            } else {
                l = m;
            }
        }
        cs[r] = a;
    }
    writeln(cs.length);
}