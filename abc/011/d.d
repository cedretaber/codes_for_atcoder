import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    auto D = nd[1];
    auto xy = readln.split.to!(int[]);

    if (xy[0]%D != 0 || xy[1]%D != 0) {
        writeln(0);
        return;
    }

    auto X = abs(xy[0]) / D;
    auto Y = abs(xy[1]) / D;

    if (N-X-Y < 0 || (N-X-Y)%2 != 0) {
        writeln(0);
        return;
    }

    auto PT = new double[][](N+1, N+1);
    foreach (ref pt; PT) pt[] = 0;
    PT[0][0] = 1;
    foreach (i; 1..N+1) {
        foreach (j; 0..i) {
            PT[i][j] += PT[i-1][j] / 2;
            PT[i][j+1] += PT[i-1][j] / 2;
        }
    }

    double r = 0;
    foreach (h; 0..N+1) {
        auto w = N-h;
        if (h < Y || (h-Y)%2 != 0 || w < X || (w-X)%2 != 0) continue;
        r += PT[N][h] * PT[h][Y + (h-Y)/2] * PT[w][X + (w-X)/2];
    }

    writefln("%.12f", r);
}