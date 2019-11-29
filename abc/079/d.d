import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[10][10] CS;

void main()
{
    int H = readln.split.to!(int[])[0];

    foreach (i; 0..10) CS[i][] = readln.split.to!(int[])[];

    foreach (_; 0..10)
        foreach (i; 0..10)
            foreach (j; 0..10)
                foreach (k; 0..10)
                    if (CS[i][j] > CS[i][k] + CS[k][j])
                        CS[i][j] = CS[i][k] + CS[k][j];

    int c;
    foreach (_; 0..H) {
        auto l = readln.split.to!(int[]);
        foreach (e; l) if (e != -1) c += CS[e][1];
    }
    writeln(c);
}