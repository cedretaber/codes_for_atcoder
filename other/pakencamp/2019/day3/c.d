import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    long[][] as;
    as.length = N;
    foreach (i; 0..N) as[i] = readln.split.to!(long[]);

    long r;
    foreach (i; 0..M-1) {
        foreach (j; i+1..M) {
            long rr;
            foreach (k; 0..N) {
                rr += max(as[k][i], as[k][j]);
            }
            r = max(r, rr);
        }
    }
    writeln(r);
}