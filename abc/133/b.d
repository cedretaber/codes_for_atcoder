import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    auto D = nd[1];
    int[][] xs;
    xs.length = N;
    foreach (i; 0..N) {
        xs[i] = readln.split.to!(int[]);
    }

    int c;
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            int d;
            foreach (k; 0..D) {
                d += (xs[i][k] - xs[j][k]) ^^ 2;
            }
            int dd = sqrt(d.to!double).to!int^^2;
            if (d == dd) ++c;
        }
    }
    writeln(c);
}