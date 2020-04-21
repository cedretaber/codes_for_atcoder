import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto M = readln.chomp.to!int;
    auto ts = readln.split.to!(int[]);
    auto rs = new int[](N);
    foreach (i; 0..M) {
        auto bs = readln.split.to!(int[]);
        auto t = ts[i];
        int c;
        foreach (j, b; bs) {
            if (t == b) {
                ++rs[j];
            } else {
                ++c;
            }
        }
        rs[t-1] += c;
    }
    foreach (r; rs) writeln(r);
}