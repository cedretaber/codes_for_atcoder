import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto CS = new long[][](10, 10);
    foreach (i; 0..10) {
        foreach (j, c; readln.split.to!(long[])) CS[i][j] = c;
    }

    foreach (k; 0..10) {
        foreach (i; 0..10) {
            foreach (j; 0..10) {
                if (CS[i][j] > CS[i][k] + CS[k][j]) {
                    CS[i][j] = CS[i][k] + CS[k][j];
                }
            }
        }
    }

    long r;
    foreach (_; 0..H) {
        foreach (n; readln.split.to!(int[])) if (n != -1) {
            r += CS[n][1];
        }
    }
    writeln(r);
}