import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;


void main()
{
    auto N = readln.chomp.to!int;
    auto HS = readln.split.to!(int[]);

    int[] cs = [HS[0]-1, HS[0]];
    foreach (h; HS[1..$]) {
        if (cs.length == 1) {
            auto c = cs[0];
            if (h > c) {
                cs = [h-1, h];
            } else if (c == h) {
                cs = [h];
            } else {
                writeln("No");
                return;
            }
        } else {
            if (h >= cs[1]) {
                cs = [h-1, h];
            } else if (h == cs[0]) {
                cs = [h];
            } else {
                writeln("No");
                return;
            }
        }
    }
    writeln("Yes");
}