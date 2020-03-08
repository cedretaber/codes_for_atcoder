import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        T[ab[0]-1] ~= ab[1]-1;
        T[ab[1]-1] ~= ab[0]-1;
    }
    int[3] ns;
    foreach (i; 1..N+1) ++ns[i%3];

    auto cs = new int[](N);
    int o, t;
    void put(int i, int p, int c) {
        cs[i] = c;
        if (c == 1) ++o; else ++t;
        foreach (j; T[i]) if (j != p) put(j, i, c == 1 ? 2 : 1);
    }
    put(0, -1, 1);

    if (o <= ns[0] + ns[1] && t <= ns[0] + ns[2]) {
        o = 1; t = 2;
        auto r = 3;
        foreach (i; 0..N) {
            if (cs[i] == 1) {
                if (o <= N) {
                    cs[i] = o;
                    o += 3;
                } else {
                    cs[i] = r;
                    r += 3;
                }
            } else {
                if (t <= N) {
                    cs[i] = t;
                    t += 3;
                } else {
                    cs[i] = r;
                    r += 3;
                }
            }
        }
    } else {
        auto m = o > t ? 1 : 2;
        o = 1; t = 2;
        auto r = 3;
        foreach (i; 0..N) {
            if (cs[i] == m) {
                if (o <= N) {
                    cs[i] = o;
                    o += 3;
                } else if (t <= N) {
                    cs[i] = t;
                    t += 3;
                } else {
                    cs[i] = r;
                    r += 3;
                }
            } else {
                cs[i] = r;
                r += 3;
            }
        }
    }

    writeln(cs.to!(string[]).join(" "));
}