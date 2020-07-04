import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range, core.bitop;

alias E = Tuple!(bool, "is_over", int, "s", int, "t");

void main()
{
    auto N = readln.chomp.to!int;
    E[] es;
    foreach (_; 0..N) {
        auto st = readln.split.map!(t => t.split(":").to!(int[])).array;
        auto s = st[0][0] * 60 + st[0][1];
        auto t = st[1][0] * 60 + st[1][1];
        if (t < 24 * 60) {
            es ~= E(false, s, t);
        } else {
            es ~= E(true, t - 24 * 60, s);
        }
    }
    auto rel = new ulong[](N);
    foreach (i; 0..N) {
        rel[i] |= 1L<<i;
        foreach (j; i+1..N) {
            auto a = es[i];
            auto b = es[j];
            if (a.is_over && b.is_over) continue;
            if (a.is_over) swap(a, b);
            bool ok;
            if (b.is_over) {
                ok = b.s <= a.s && a.t <= b.t;
            } else {
                ok = !(
                    (a.s <= b.s && a.t >= b.t) ||
                    (b.s <= a.s && b.t >= a.t) ||
                    (a.s <= b.s && b.s < a.t) ||
                    (b.s <= a.s && a.s < b.t)
                );
            }
            if (ok) {
                rel[i] |= 1L<<j;
                rel[j] |= 1L<<i;
            }
        }
    }
    auto xs = 1.iota(2^^N).array;
    sort!((a, b) => popcnt(a) < popcnt(b))(xs);

    auto DP = new int[](2^^N);
    foreach (x; xs) {
        auto l = popcnt(x);
        ulong e, s = 2^^N-1;
        foreach (i; 0..N) if (x & (1L<<i)) {
            e |= 1L<<i;
            s &= rel[i];
        }
        if ((e&s) == e) {
            DP[x] = 1;
        } else {
            int r = l;
            foreach (y; 1..(1L<<(l-1))) {
                ulong a, b;
                int j;
                foreach (i; 0..N) if (x & (1L<<i)) {
                    if (y&(1L<<j)) {
                        a |= 1L<<i;
                    } else {
                        b |= 1L<<i;
                    }
                    ++j;
                }
                r = min(r, DP[a] + DP[b]);
            }
            DP[x] = r;
        }
    }
    writeln(DP[2^^N-1]);
}

/*

> 2**15*1 + 2**14*15 + 2**13*105 + 2**12*455 + 2**11*1365 + 2**10*3003 + 2**9*5005 + 2**8*6435 + 2**7*6435 + 2**6*5005 + 2**5*3003 + 2**4*1365 + 2**3*455 + 2**2*105 + 2**1*15 + 2**0*1
=> 14348907

*/