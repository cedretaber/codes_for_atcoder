import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias A = Tuple!(long, "a", long, "b");

void main()
{
    auto N = readln.chomp.to!int;
    A[] as;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        as ~= A(ab[0], ab[1]);
    }
    sort!"a < b"(as);
    auto cs = new long[](N);
    foreach (i; 0..N) {
        if (i) cs[i] = cs[i-1];
        cs[i] += as[i].b;
    }
    auto d = as[0].a;
    long r;
    foreach (i; 0..N) {
        r = max(r, cs[i] - as[i].a + d);
        d = max(d, -cs[i] + (i+1 < N ? as[i+1].a : 0));
    }
    writeln(r);
}