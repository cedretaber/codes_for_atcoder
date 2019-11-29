import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

long[10^^5] AS, BS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        AS[i] = readln.chomp.to!long;
    }
    sort(AS[0..N]);

    if (N == 2) {
        writeln(AS[1] - AS[0]);
        return;
    }

    BS[N/2] = AS[0];
    int i = 0, j = N, a = N/2-1, b = N/2+1, x = 1;
    for (;;) {
        if (x++ % 2) {
            --j;
            if (i == j) break;
            BS[a--] = AS[j];
            --j;
            if (i == j) break;
            BS[b++] = AS[j];
        } else {
            ++i;
            if (i == j) break;
            BS[a--] = AS[i];
            ++i;
            if (i == j) break;
            BS[b++] = AS[i];
        }
    }
    long r1;
    i = 0;
    j = 1;
    while (j != N) {
        r1 += abs(BS[i++] - BS[j++]);
    }

    BS[N/2] = AS[N-1];
    i = -1;
    j = N-1;
    a = N/2-1;
    b = N/2+1;
    x = 0;
    for (;;) {
        if (x++ % 2) {
            --j;
            if (i == j) break;
            BS[a--] = AS[j];
            --j;
            if (i == j) break;
            BS[b++] = AS[j];
        } else {
            ++i;
            if (i == j) break;
            BS[a--] = AS[i];
            ++i;
            if (i == j) break;
            BS[b++] = AS[i];
        }
    }
    long r2;
    i = 0;
    j = 1;
    while (j != N) {
        r2 += abs(BS[i++] - BS[j++]);
    }

    writeln(max(r1, r2));
}