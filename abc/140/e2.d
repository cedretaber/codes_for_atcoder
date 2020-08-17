import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(long, "i", long, "p");

void main()
{
    auto N = readln.chomp.to!long;
    auto ii = new long[](N+1);
    foreach (i, p; readln.split.to!(long[])) ii[p] = i.to!long+1;
    auto T = redBlackTree!true(0, 0, ii[N], N+1, N+1);
    long res;
    foreach_reverse (p; 1..N) {
        auto c = ii[p];
        T.insert(c);
        auto l = T.lowerBound(c);
        auto b = l.back;
        l.popBack();
        auto a = l.back;
        auto r = T.upperBound(c);
        auto d = r.front;
        r.popFront();
        auto e = r.front;
        res += ((b-a)*(d-c) + (c-b)*(e-d)) * p;
    }
    writeln(res);
}