import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

extern (C) int Compare(int X, int Y);

extern (C) void Answer(int X, int Y);

extern (C)
void Ramen(int N) {
    int[] hs, ls;
    hs.reserve(N/2);
    ls.reserve(N/2);
    for (int i = 1; i+1 < N; i += 2) {
        if (Compare(i, i+1) == 1) {
            hs ~= i;
            ls ~= i+1;
        } else {
            hs ~= i+1;
            ls ~= i;
        }
    }
    int h = 0, l = 0;
    if (N%2 == 0) {
        if (Compare(0, N-1) == 1) {
            l = N-1;
        } else {
            h = N-1;
        }
    }

    foreach (j; hs) {
        if (Compare(h, j) == -1) {
            h = j;
        }
    }
    foreach (j; ls) {
        if (Compare(l, j) == 1) {
            l = j;
        }
    }

    Answer(l, h);
}