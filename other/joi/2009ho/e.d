import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias D = Tuple!(int, "l", int, "r");
alias S = Tuple!(int, "x", int, "y", int, "l");

void main()
{
    auto R = readln.chomp.to!int;

    void count(ref D[] ds) {
        auto whxy = readln.split.to!(int[]);
        auto W = whxy[0];
        auto H = whxy[1];
        auto X = whxy[2]-1;
        auto Y = whxy[3]-1;

        int[][] MAP;
        foreach (_; 0..H) MAP ~= readln.split.to!(int[]);
        auto MEMO = new int[][](H, W);
        MEMO[Y][X] = 1;
        auto Q = heapify!"a.l > b.l"([S(X, Y, 1)]);
        while (!Q.empty) {
            auto h = Q.front;
            auto l = h.l;
            Q.popFront();
            static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
                auto x = h.x+d[0];
                auto y = h.y+d[1];
                if (0 <= x && x < W && 0 <= y && y < H && (MEMO[y][x] == 0 || MEMO[y][x] > l)) {
                    auto ml = MAP[y][x];
                    if (ml > l) {
                        MEMO[y][x] = ml;
                        Q.insert(S(x, y, ml));
                    } else {
                        MEMO[y][x] = l;
                        Q.insert(S(x, y, l));
                    }
                }
            }}
        }
        int[int] rs;
        foreach (i; 0..H) foreach (j; 0..W) ++rs[MEMO[i][j]];
        foreach (l, r; rs) ds ~= D(l, r);
        sort!"a.l < b.l"(ds);
        foreach (i; 1..ds.length) {
            ds[i].r += ds[i-1].r;
        }
    }

    D[] ds1, ds2;
    count(ds1);
    count(ds2);

    int min_l = int.max;
    foreach (d; ds1) {
        if (d.r >= R) {
            min_l = min(min_l, d.l);
            continue;
        }

        if (d.r + ds2[0].r >= R) {
            min_l = min(min_l, d.l + ds2[0].l);
        } else if (d.r + ds2[$-1].r >= R) {
            int l, r = ds2.length.to!int-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (d.r + ds2[m].r >= R) {
                    r = m;
                } else {
                    l = m;
                }
            }
            min_l = min(min_l, d.l + ds2[r].l);
        }
    }
    writeln(min_l);
}