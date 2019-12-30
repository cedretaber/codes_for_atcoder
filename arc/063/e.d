import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(long, "min", long, "max", bool, "odd", bool, "init");

void main()
{
    auto N = readln.chomp.to!int;
    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        T[A] ~= B;
        T[B] ~= A;
    }
    auto PS = new P[](N);
    int[] ks;
    auto RS = new long[](N);
    auto K = readln.chomp.to!int;
    foreach (_; 0..K) {
        auto vp = readln.split.to!(int[]);
        auto v = vp[0]-1;
        auto p = vp[1];
        PS[v].min = p;
        PS[v].max = p;
        PS[v].odd = p%2 == 1;
        PS[v].init = true;
        RS[v] = p;
        ks ~= v;
    }

    bool walk(int i, int p) {
        if (p != -1) {
            auto p_min = PS[p].min - 1;
            auto p_max = PS[p].max + 1;
            bool was_same = PS[i].init && PS[i].min == PS[i].max;
            if (!PS[i].init) {
                PS[i].min = p_min;
                PS[i].max = p_max;
                PS[i].odd = !PS[p].odd;
                PS[i].init = true;
            } else if (PS[i].min != PS[i].max) {
                PS[i].min = max(PS[i].min, p_min);
                PS[i].max = min(PS[i].max, p_max);
            } else if (PS[i].min < p_min || PS[i].max > p_max) {
                return false;
            }
            if (p_min > p_max) return false;
            if (PS[i].odd == PS[p].odd) return false;
            if (was_same) return true;
        }

        foreach (j; T[i]) if (j != p) {
            if (!walk(j, i)) return false;
        }

        return true;
    }
    foreach (i; ks) {
        if (!walk(i, -1)) {
            writeln("No");
            return;
        }
    }

    void paint(int i, int p) {
        if (p != -1) {
            auto min_p = RS[p] - 1;
            auto max_p = RS[p] + 1;
            if (PS[i].min <= min_p && min_p <= PS[i].max) {
                RS[i] = min_p;
            } else if (PS[i].min <= max_p && max_p <= PS[i].max) {
                RS[i] = max_p;
            } else {
                throw new Exception("");
            }
        }

        foreach (j; T[i]) if (j != p) {
            paint(j, i);
        }
    }
    paint(ks[0], -1);

    writeln("Yes\n", RS[].to!(string[]).join("\n"));
}