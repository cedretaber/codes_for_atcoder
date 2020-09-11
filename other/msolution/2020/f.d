import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "x", int, "y");

void main()
{
    auto N = readln.chomp.to!int;

    auto us = new int[][200001];
    auto rs = new int[][200001];
    auto ds = new int[][200001];
    auto ls = new int[][200001];

    P[] ups, dps;
    int[][int] rpps, rmps, lpps, lmps;
    foreach (_; 0..N) {
        auto xyu = readln.split;
        auto p = P(xyu[0].to!int, xyu[1].to!int);
        switch (xyu[2]) {
            case "U":
                us[p.x] ~= p.y;
                ups ~= p;
                break;
            case "R":
                rs[p.y] ~= p.x;
                rpps[p.x+p.y] ~= p.y;
                rmps[p.x-p.y] ~= p.y;
                break;
            case "D":
                ds[p.x] ~= p.y;
                dps ~= p;
                break;
            case "L":
                ls[p.y] ~= p.x;
                lpps[p.x+p.y] ~= p.y;
                lmps[p.x-p.y] ~= p.y;
                break;
            default:
        }
    }

    auto res = int.max;

    void update_same_direction(int a, int b) {
        res = min(res, abs(a - b) * 10 / 2);
    }
    void same_direction(int[][] as, int[][] bs) {
        foreach (i, aa; as) if (!aa.empty && !bs[i].empty) {
            auto bb = bs[i];
            sort(bb);
            foreach (u; aa) {
                if (bb[0] > u) {
                    update_same_direction(u, bb[0]);
                } else if (bb[$-1] > u) {
                    int l, r = bb.length.to!int-1;
                    while (l+1 < r) {
                        auto m = (l+r)/2;
                        if (bb[m] > u) {
                            r = m;
                        }  else {
                            l = m;
                        }
                    }
                    update_same_direction(u, bb[r]);
                }
            }
        }
    }
    same_direction(us, ds);
    same_direction(rs, ls);

    foreach (_, ref v; rpps) sort(v);
    foreach (_, ref v; rmps) sort(v);
    foreach (_, ref v; lpps) sort(v);
    foreach (_, ref v; lmps) sort(v);
    void update_parpendicular(int a, int b) {
        res = min(res, abs(a - b) * 10);
    }
    void parpendicular_direction_up(int key, P p, int[][int] pps) {
        if (key in pps) {
            auto rr = pps[key];
            if (rr[0] > p.y) {
                update_parpendicular(rr[0], p.y);
            } else if (rr[$-1] > p.y) {
                int l, r = rr.length.to!int-1;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (rr[m] > p.y) {
                        r = m;
                    } else {
                        l = m;
                    }
                }
                update_parpendicular(rr[r], p.y);
            }
        }
    }
    foreach (p; ups) {
        parpendicular_direction_up(p.x-p.y, p, lmps);
        parpendicular_direction_up(p.x+p.y, p, rpps);
    }
    void parpendicular_direction_down(int key, P p, int[][int] pps) {
        if (key in pps) {
            auto rr = pps[key];
            if (rr[$-1] < p.y) {
                update_parpendicular(rr[$-1], p.y);
            } else if (rr[0] < p.y) {
                int l, r = rr.length.to!int-1;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (rr[m] < p.y) {
                        l = m;
                    } else {
                        r = m;
                    }
                }
                update_parpendicular(rr[l], p.y);
            }
        }
    }
    foreach (p; dps) {
        parpendicular_direction_down(p.x-p.y, p, rmps);
        parpendicular_direction_down(p.x+p.y, p, lpps);
    }

    if (res == int.max) {
        writeln("SAFE");
    } else {
        writeln(res);
    }
}

/*

8
168 224 U  392/-56
130 175 R  305/-45
111 198 D  309/-87
121 188 L  309/-67
201 116 U  317/85 
112 121 R  233/-9
145 239 D  384/-94
185 107 L  292/78

111,198 -> 111,197 -> 111,196 ...
121,188 -> 120,188 -> 119,188 ...

111,198 -> 112,197 -> 113,196 -> 114,195 -> 115,194 -> 116,193 -> 117,192 -> 118,191 -> 119,190 -> 120,189 -> 121,188

2
111 198 D
101 188 R

2
111 178 U
121 188 L

2
101 188 R
111 178 U


0 4 R x+y=4
4 0 U x+y=4
y = -x + b

8 4 L x-y=4
4 0 U x-y=4
y = x + b

0 4 R x-y=-4
4 8 D x-y=-4
y = -x + b

8 4 L x+y=12
4 8 D x+y=12
y = -x + b

    *
    +
    +
    +
*+++++++*
    +
    +
    +
    *

*/