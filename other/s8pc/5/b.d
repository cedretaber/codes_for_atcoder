import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

double solve(double x1, double y1, double x2, double y2)
{
    return sqrt((x1-x2)^^2 + (y1-y2)^^2) / 2;
}

double solve(double x1, double y1, double x2, double y2, double r)
{
    return sqrt((x1-x2)^^2 + (y1-y2)^^2) - r;
}

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    double[] xs, ys, rs;
    double min_r = 1000;
    foreach (_; 0..N) {
        auto xyr = readln.split.to!(double[]);
        xs ~= xyr[0];
        ys ~= xyr[1];
        rs ~= xyr[2];
        min_r = min(min_r, xyr[2]);
    }
    foreach (_; 0..M) {
        auto xy = readln.split.to!(double[]);
        xs ~= xy[0];
        ys ~= xy[1];
    }
    foreach (i; 0..M) {
        foreach (j; 0..N) {
            min_r = min(min_r, solve(xs[N+i], ys[N+i], xs[j], ys[j], rs[j]));
        }
        foreach (j; i+1..M) {
            min_r = min(min_r, solve(xs[N+i], ys[N+i], xs[N+j], ys[N+j]));
        }
    }
    writefln("%.10f", min_r);
}