import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rc = readln.split.to!(int[]);
    auto R = rc[0];
    auto C = rc[1];
    auto SS = new bool[][](R, C);
    foreach (i; 0..R) {
        foreach (j, c; readln.split) SS[i][j] = c == "1";
    }
    int r;
    foreach (x; 0..(1<<R)) {
        int rr;
        foreach (j; 0..C) {
            int a, b;
            foreach (i; 0..R) {
                if (x & (1<<i)) {
                    if (SS[i][j]) ++a; else ++b;
                } else {
                    if (SS[i][j]) ++b; else ++a;
                }
            }
            rr += max(a, b);
        }
        r = max(r, rr);
    }
    writeln(r);
}