import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto DIC = new bool[][](N+1, N+1);
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        DIC[ab[0]][ab[1]] = true;
    }
    auto CDIC = new long[][](N+1, N+1);
    foreach (i; 1..N+1) {
        foreach (j; 1..N+1) {
            foreach (k; 1..N+1) {
                if (DIC[i][k] && DIC[j][k]) CDIC[i][j] += 1;
            }
        }
    }
    long r;
    foreach (i; 1..N+1) {
        foreach (j; 1..N+1) {
            foreach (k; 1..N+1) {
                if (DIC[i][j] && DIC[i][k]) {
                    r += CDIC[k][j];
                }
            }
        }
    }
    writeln(r);
}