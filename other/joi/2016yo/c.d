import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    char[][] F;
    F.length = N;
    foreach (i; 0..N) F[i] = readln.chomp.to!(char[]);

    int w, res = int.max;
    foreach (i; 0..N-2) {
        foreach (j; 0..M) if (F[i][j] != 'W') ++w; 
        int b, r;
        foreach (j; i+1..N) foreach (k; 0..M) if (F[j][k] != 'R') ++r;
        foreach (j; i+1..N-1) {
            foreach (k; 0..M) {
                if (F[j][k] != 'B') ++b;
                if (F[j][k] != 'R') --r;
            }
            res = min(res, w + b + r);
        }
    }
    writeln(res);
}