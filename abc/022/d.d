import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(double, "x", double, "y");

P[10^^5] AS, BS;

void main()
{
    auto N = readln.chomp.to!int;
    auto GA = P(0, 0), GB = P(0, 0);
    foreach (i; 0..N) {
        auto xy = readln.split.to!(double[]);
        AS[i] = P(xy[0], xy[1]);
        GA.x += xy[0];
        GA.y += xy[1];
    }
    GA.x /= N;
    GA.y /= N;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(double[]);
        BS[i] = P(xy[0], xy[1]);
        GB.x += xy[0];
        GB.y += xy[1];
    }
    GB.x /= N;
    GB.y /= N;

    double dist(P a, P b) {
        return sqrt((a.x - b.x)^^2 + (a.y - b.y)^^2);
    }
    
    auto max_da = -1., max_db = -1.;
    foreach (i; 0..N) {
        max_da = max(max_da, dist(GA, AS[i]));
        max_db = max(max_db, dist(GB, BS[i]));
    }

    writefln("%.10f", max_db / max_da);
}