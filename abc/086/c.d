import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int N;
int[10^^5] ts, xs, ys;

void main()
{
    readf("%d", &N);
    foreach (i; 0..N)
        readf(" %d %d %d", &ts[i], &xs[i], &ys[i]);
    
    int x, y, t, d;
    foreach (i; 0..N) {
        d = (xs[i] - x).abs + (ys[i] - y).abs;
        t = i == 0 ? ts[i] : ts[i] - ts[i-1];
        if (d > t || (t-d)%2 == 1) {
            writeln("No");
            return;
        } else {
            x = xs[i];
            y = ys[i];
        }
    }
    writeln("Yes");
}