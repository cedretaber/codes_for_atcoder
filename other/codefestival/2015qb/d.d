import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import std.container.rbtree;

alias R = Tuple!(size_t, "l", size_t, "r");

void main()
{
    auto N = readln.chomp.to!int;

    auto sc = readln.split.to!(size_t[]);
    auto S = sc[0];
    auto C = sc[1];
    writeln(S+C-1);

    auto rbt = redBlackTree!"a.l < b.l"(R(S, S+C-1));
    foreach (_; 0..N-1) {
        sc = readln.split.to!(size_t[]);
        S = sc[0];
        C = sc[1];
        auto r = R(S, S+C-1);

        auto l = rbt.lowerBound(r);
        auto e = rbt.equalRange(r);
        auto u = rbt.upperBound(r);

        if (!l.empty && l.back.r >= S) {
            auto x = l.back;
            rbt.removeKey(x);
            S = x.l;
            C += x.r - x.l + 1;
        }
        if (!e.empty) {
            C += e.front.r - e.front.l + 1;
            rbt.removeKey(r);
        }

        while (!u.empty && u.front.l <= S+C-1) {
            auto x = u.front;
            rbt.removeKey(x);
            u = rbt.upperBound(r);
            C += x.r - x.l + 1;
        }

        writeln(S+C-1);
        rbt.insert(R(S, S+C-1));
    }
}