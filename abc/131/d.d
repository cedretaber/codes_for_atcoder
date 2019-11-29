import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias W = Tuple!(long, "a", long, "b");

W[10^^5*2] WS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(long[]);
        WS[i] = W(ab[0], ab[1]);
    }
    sort!"a.b < b.b"(WS[0..N]);
    long t;
    foreach (w; WS[0..N]) {
        t += w.a;
        if (w.b < t) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}