import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias Point = Tuple!(int, "x", int, "y");

Point[][1000][1000] PS;

int rev(int x) {
    int[] ns;
    while (x) {
        ns ~= (x % 10);
        x /= 10;
    }
    int y;
    foreach (i, n; ns) {
        y += n * 10^^(ns.length-1-i);
    }
    return y;
}

void main()
{
    foreach (x; 1..1000) {
        foreach (y; 1..1000) {
            auto nx = x, ny = y;
            if (nx < ny) {
                nx = rev(nx);
            } else {
                ny = rev(ny);
            }
            if (nx < ny) {
                ny -= nx;
            } else {
                nx -= ny;
            }
            PS[ny][nx] ~= Point(x, y);
        }
    }

    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    int cnt;
    Point[] q;
    void solve() {
        while (!q.empty) {
            auto x = q[0].x, y = q[0].y;
            q = q[1..$];
            if (x <= N && y <= M && x > 0 && y > 0) {
                ++cnt;
            }
            foreach (p; PS[y][x]) {
                q ~= p;
            }
        }
    }
    foreach (x; 1..1000) {
        q = [Point(x, 0)];
        solve();
    }
    foreach (y; 1..1000) {
        q = [Point(0, y)];
        solve();
    }
    writeln(N * M - cnt);
}