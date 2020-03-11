import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] AS, cs;
    foreach (_; 0..N) AS ~= readln.chomp.to!int;
    foreach (a; AS) {
        if (cs.empty || cs[$-1] >= a) {
            cs ~= a;
        } else if (cs[0] < a) {
            cs[0] = a;
        } else {
            int l, r = cs.length.to!int-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (a > cs[m]) {
                    r = m;
                } else {
                    l = m;
                }
            }
            cs[r] = a;
        }
    }
    writeln(cs.length);
}