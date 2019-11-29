import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(size_t, "x", size_t, "y");

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    char[][] AS;
    AS.length = H;
    foreach (i; 0..H) {
        AS[i] = readln.chomp.to!(char[]);
    }

    int[][] BS;
    BS.length = H;
    foreach (ref bs; BS) {
        bs.length = W;
        bs[] = -1;
    }

    P[] ps;

    foreach (y, as; AS) {
        foreach (x, c; as) {
            if (c == '#') {
                ps ~= P(x, y);
            }
        }
    }

    int t;
    while (!ps.empty) {
        P[] nps;
        foreach (p; ps) {
            if (BS[p.y][p.x] != -1) continue;
            BS[p.y][p.x] = t;
            foreach (xy; [[1, 0], [0, 1], [-1, 0], [0, -1]]) {
                auto x = p.x + xy[0];
                auto y = p.y + xy[1];
                if (x < 0 || x >= W || y < 0 || y >= H) continue;
                nps ~= P(x, y);
            }
        }
        ps = nps;
        ++t;
    }

    auto r = int.min;
    foreach (bs; BS) foreach (b; bs) r = max(r, b);
    writeln(r);
}