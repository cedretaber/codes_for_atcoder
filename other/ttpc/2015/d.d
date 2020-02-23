import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto cs = "13579".to!(dchar[]);
    auto S = readln.chomp.to!(char[]);
    do {
        int[char] map;
        char[] s;
        int i;
        foreach (ref c; S) {
            if (c !in map) {
                if (i >= cs.length) {
                    writeln("-1");
                    return;
                }
                map[c] = i++;
            }
            s ~= cs[map[c]];
        }
        auto n = s.to!long;
        if (n == 1) goto ng;
        for (long x = 2; x^^2 <= n; ++x) {
            if (n % x == 0) goto ng;
        }
        writeln(n);
        return;
        ng:
    } while (nextPermutation(cs));
    writeln(-1);
}