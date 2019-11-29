import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias Q = Tuple!(int, "x", int, "y");

void main()
{
    Q[8] QS;
    int i;
    foreach (int y; 0..8) {
        foreach (x, c; readln.chomp.to!(char[])) {
            if (c == 'Q') QS[i++] = Q(x.to!int, y);
        }
    }

    foreach (j; 0..3) {
        foreach (k; i+1..3) {
            auto a = QS[j];
            auto b = QS[k];
            if (
                a.x == b.x ||
                a.y == b.y ||
                abs(a.x-b.x) == abs(a.y-b.y)
            ) {
                writeln("No Answer");
                return;
            }
        }
    }

    bool solve(int x, int y, int i) {
        if (i == 8) return true;
        if (y >= 8) return false;
        bool ok = true;
        foreach (q; QS[0..i]) {
            if (
                x == q.x ||
                y == q.y ||
                abs(x-q.x) == abs(y-q.y)
            ) {
                ok = false;
                break;
            }
        }
        auto nxy = y*8+x+1;
        auto nx = nxy%8;
        auto ny = nxy/8;
        if (ok) {
            QS[i] = Q(x, y);
            if (solve(nx, ny, i+1)) return true;
        }
        return solve(nx, ny, i);
    }

    if (solve(0, 0, i)) {
        char[][] R;
        R.length = 8;
        foreach (ref line; R) line = "........".to!(char[]);
        foreach (q; QS) R[q.y][q.x] = 'Q';
        foreach (line; R) writeln(line);
    } else {
        writeln("No Answer");
    }
}