import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "i", int, "a");

void main()
{
    auto N = readln.chomp.to!int;
    P[] ps;
    foreach (i, a; readln.split.to!(int[])) ps ~= P(i.to!int, a);
    auto res = new int[](2^^N);

    foreach (i; 1..N+1) {
        P[] nps;
        size_t j;
        while (j < ps.length) {
            auto a = ps[j];
            auto b = ps[j+1];
            if (a.a > b.a) {
                res[b.i] = i;
                nps ~= a;
            } else {
                res[a.i] = i;
                nps ~= b;
            }
            j += 2;
        }
        ps = nps;
    }
    res[ps[0].i] = N;
    foreach (r; res) writeln(r);
}