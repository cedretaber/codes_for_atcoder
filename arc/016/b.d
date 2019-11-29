import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    char[] prev;
    int r;
    foreach (_; 0..N) {
        auto l = readln.chomp.to!(char[]);
        foreach (i, e; l) {
            if ((e == 'x') || (e == 'o' && (prev.empty || prev[i] != 'o'))) {
                ++r;
            }
        }
        prev = l;
    }
    writeln(r);
}