import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rck = readln.split.to!(int[]);
    auto R = rck[0];
    auto C = rck[1];
    auto K = rck[2];
    int[][] MAP;
    MAP.length = R;
    foreach (i; 0..R) {
        MAP[i].length = C;
        foreach (j, c; readln.chomp.to!(char[])) {
            MAP[i][j] = c == 'x' ? K-1 : -1;
        }
    }
    int x = -1;
    void put(ref int n) {
        if (n < x) {
            n = x;
        } else {
            x = n;
        }
        --x;
    }
    foreach (i; 0..R) { x = -1; foreach (j; 0..C) put(MAP[i][j]); }
    foreach (i; 0..R) { x = -1; foreach_reverse (j; 0..C) put(MAP[i][j]); }
    foreach (j; 0..C) { x = -1; foreach (i; 0..R) put(MAP[i][j]); }
    foreach (j; 0..C) { x = -1; foreach_reverse (i; 0..R) put(MAP[i][j]); }

    int r;
    foreach (i; K-1..R-K+1) foreach (j; K-1..C-K+1) if (MAP[i][j] == -1) ++r;
    writeln(r);
}