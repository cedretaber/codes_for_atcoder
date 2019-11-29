import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto hs = readln.split.to!(int[]);
    auto max_h = hs[0];
    int r;
    foreach (h; hs) {
        if (h >= max_h) {
            ++r;
            max_h = h;
        }
    }
    writeln(r);
}