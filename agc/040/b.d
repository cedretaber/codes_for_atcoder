import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(long, "l", long, "r");

void main()
{
    auto N = readln.chomp.to!int;
    P[] ps;
    foreach (_; 0..N) {
        auto lr = readln.split.to!(long[]);
        ps ~= P(lr[0], lr[1]);
    }
    sort!"a.l == b.l ? a.r < b.r : a.l < b.l"(ps);

    auto ls = new long[](N);
    ls[0] = ps[0].r;
    foreach (i; 1..N) ls[i] = min(ls[i-1], ps[i].r);

    auto rs = new long[](N);
    rs[$-1] = ps[$-1].r;
    foreach_reverse (i; 0..N-1) rs[i] = min(rs[i+1], ps[i].r);

    long res;
    foreach (i; 0..N-1) {
        res = max(
            res,
            max(0, ls[i] - ps[i].l + 1) + max(0, rs[i+1] - ps[$-1].l + 1),
            max(0, ps[i].r - ps[i].l + 1) + max(0, rs[0] - ps[$-1].l + 1)
        );
    }
    writeln(res);
}