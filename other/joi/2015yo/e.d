import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "i", int, "j");

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto MAP = new int[][](H, W);
    foreach (i; 0..H) foreach (j, c; readln.chomp) {
        if (c == '.') {
            MAP[i][j] = 0;
        } else {
            MAP[i][j] = c - '0';
        }
    }
    bool[P] ns;
    P[] ps;

    void run(int i, int j, ref bool[P] ns) {
        if (MAP[i][j] == 0) return;

        int c;
        foreach (id; [1, 0, -1]) foreach (jd; [1, 0, -1]) if (id != 0 || jd != 0) {
            if (MAP[i+id][j+jd] == 0) ++c;
        }
        if (MAP[i][j] <= c) {
            foreach (id; [1, 0, -1]) foreach (jd; [1, 0, -1]) if (id != 0 || jd != 0) ns[P(i+id, j+jd)] = true;
            ps ~= P(i, j);
        }
    }
    foreach (i; 1..H-1) foreach (j; 1..W-1) run(i, j, ns);

    int r;
    while (!ps.empty) {
        ++r;
        foreach (p; ps) MAP[p.i][p.j] = 0;
        ps = [];
        bool[P] nns;
        foreach (p, _; ns) run(p.i, p.j, nns);
        ns = nns;
    }
    writeln(r);
}