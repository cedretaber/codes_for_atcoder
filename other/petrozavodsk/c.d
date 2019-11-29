import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    writeln(0);
    stdout.flush();
    auto f = readln.chomp;
    if (f == "Vacant") return;
    int l = 0, r = N;
    for (;;) {
        auto m = (l+r)/2;
        writeln(m);
        stdout.flush();
        auto x = readln.chomp;
        if (x == "Vacant") {
            return;
        } else if (m%2 == 0 && x == f || m%2 == 1 && x != f) {
            l = m;
        } else {
            r = m;
        }
    }
}