import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] ss = [1];
    int lc = readln.chomp.to!int;
    foreach (i; 0..N-1) {
        auto c = readln.chomp.to!int;
        if (i%2 == 1) {
            if (c == lc) {
                ss[$-1] += 1;
            } else {
                ss ~= 1;
            }
        } else {
            if (c != lc && ss.length > 1) {
                ss[$-2] += ss[$-1];
                ss = ss[0..$-1];
            }
            ss[$-1] += 1;
        }
        lc = c;
    }
    int r, i;
    foreach_reverse (s; ss) {
        if (i%2 == lc) r += s;
        ++i;
    }
    writeln(r);
}