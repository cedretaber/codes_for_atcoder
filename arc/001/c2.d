import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int[] xs, ys;
    xs.length = 8;
    ys.length = 8;

    int n;
    foreach (i; 0..8) {
        foreach (j, c; readln.chomp) if (c == 'Q') {
            xs[n] = j.to!int;
            ys[n] = i;
            ++n;
        }
    }

    foreach (i; 0..2) {
        foreach (j; i+1..3) {
            if (xs[i] == xs[j] || ys[i] == ys[j] || xs[i]+ys[j] == ys[i]+xs[j] || xs[i]+ys[i] == xs[j]+ys[j]) {
                writeln("No Answer");
                return;
            }
        }
    }

    bool solve(int p, int n) {
        if (n == 8) return true;
        if (p == 64) return false;
        auto x = p%8;
        auto y = p/8;

        foreach (i; 0..n) {
            if (x == xs[i] || y == ys[i] || x+ys[i] == y+xs[i] || x+y == xs[i]+ys[i]) goto ng;
        }
        xs[n] = x;
        ys[n] = y;
        if (solve(p+1, n+1)) return true;
        ng:
        return solve(p+1, n);
    }
    if (solve(0, 3)) {
        auto R = new char[][](8, 8);
        foreach (ref r; R) r[] = '.';
        foreach (i; 0..8) R[ys[i]][xs[i]] = 'Q';
        foreach (ref r; R) writeln(r);
    } else {
        writeln("No Answer");
    }
}