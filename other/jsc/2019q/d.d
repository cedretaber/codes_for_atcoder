import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto R = new int[](N-1);

    foreach (d; 1..N) {
        auto end = true;
        auto s = true;
        foreach (ref x; R) {
            if (x == 0) {
                end = false;
                if (s) {
                    s = false;
                    x = d;
                } else {
                    s = true;
                }
            }
        }
        if (end) break;
    }
    foreach (i; 1..N) writeln(R[0..N-i].to!(string[]).join(" "));
}