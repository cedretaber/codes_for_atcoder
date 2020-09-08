import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    int[] cs;
    foreach (_; 0..N) {
        auto c = readln.chomp.to!int;
        if (cs.empty || cs[$-1] < c) {
            cs ~= c;
        } else if (cs[0] > c) {
            cs[0] = c;
        } else {
            size_t l, r = cs.length-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (cs[m] < c) {
                    l = m;
                } else {
                    r = m;
                }
            }
            cs[r] = c;
        }
    }
    writeln(N - cs.length);
}