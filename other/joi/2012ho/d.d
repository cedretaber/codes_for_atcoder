import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[][] cs;
    cs.length = N+1;
    foreach (i; 0..N+1) cs[i].length = i+1;
    foreach (_; 0..M) {
        auto abx = readln.split.to!(int[]);
        auto a = abx[0]-1;
        auto b = abx[1]-1;
        auto x = abx[2]+1;
        cs[a][b] = max(cs[a][b], x); 
    }
    int r;
    foreach (i; 0..N) {
        foreach (j, x; cs[i]) {
            if (x > 0) ++r;
            cs[i+1][j] = max(cs[i+1][j], x-1);
            cs[i+1][j+1] = max(cs[i+1][j+1], x-1);
        }
    }
    writeln(r);
}