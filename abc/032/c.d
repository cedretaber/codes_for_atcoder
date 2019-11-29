import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5] SS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    bool has_zero;
    foreach (i; 0..N) {
        SS[i] = readln.chomp.to!long;
        if (!SS[i]) has_zero = true;
    }

    if (has_zero) {
        writeln(N);
        return;
    }

    size_t i, j = 1;
    long r, s = SS[0];
    while (i != N-1) {
        if (s <= K) r = max(r, j-i);
        if (j < N && (s <= K || i+1 == j)) {
            s *= SS[j++];
        } else {
            s /= SS[i++];
        }
    }
    writeln(r);
}