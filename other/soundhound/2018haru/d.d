import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    long[][] PS, FS, MAX_MS;
    PS.length = H;
    FS.length = H;
    MAX_MS.length = H;

    foreach (i; 0..H)
        PS[i] = readln.split.to!(long[]);
    foreach (i; 0..H)
        FS[i] = readln.split.to!(long[]);
    foreach (i; 0..H) {
        MAX_MS[i].length = W;
        MAX_MS[i][] = long.min;
    }

    long m;
    foreach (j; 0..W) {
        m = m + PS[0][j] - FS[0][j];
        MAX_MS[0][j] = m;
    }
    foreach (i; 1..H) {
        foreach (j; 0..W) {
            foreach (l; 0..j+1) {
                m = MAX_MS[i-1][j];
                foreach (p; l..j) m = m + PS[i][p] - FS[i][p]*2;
                if (l != j) m += FS[i][l] - FS[i][j];
                foreach (r; j..W) {
                    m = m + PS[i][r] - FS[i][r];
                    MAX_MS[i][r] = max(MAX_MS[i][r], m);
                }
            }
            foreach (r; j..W) {
                m = MAX_MS[i-1][j];
                foreach (p; j+1..r+1) m = m + PS[i][p] - FS[i][p]*2;
                if (r != j) m += FS[i][r] - FS[i][j];
                foreach_reverse (l; 0..j+1) {
                    m = m + PS[i][l] - FS[i][l];
                    MAX_MS[i][l] = max(MAX_MS[i][l], m);
                }
            }
        }
    }
    foreach (j; 0..W)
        writeln(MAX_MS[H-1][j]);
}
