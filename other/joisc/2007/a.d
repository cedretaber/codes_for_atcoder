import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias S = Tuple!(int, "i", int, "s");

void main()
{
    auto N = readln.chomp.to!int;
    S[] ss;
    foreach (i; 0..N) {
        ss ~= S(i, readln.chomp.to!int);
    }
    sort!"a.s > b.s"(ss);
    auto rs = new int[](N);
    int last_r;
    foreach (i; 0..N) {
        auto s = ss[i];
        if (i == 0 || s.s != ss[i-1].s) {
            rs[s.i] = i+1;
            last_r = i+1;
        } else {
            rs[s.i] = last_r;
        }
    }
    foreach (r; rs) writeln(r);
}