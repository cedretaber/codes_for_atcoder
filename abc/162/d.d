import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int idx(char c) {
    switch (c) {
        case 'R': return 0;
        case 'G': return 1;
        default: return 2;
    }
    return -1;
}

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;

    auto MEMO = new int[][](N, 3);
    foreach (i, c; S) {
        if (i) foreach (j; 0..3) MEMO[i][j] += MEMO[i-1][j];
        MEMO[i][idx(c)] += 1;
    }
    long r;
    foreach (i; 1..N-1) {
        auto m = S[i];
        foreach (j; 0..i) {
            if (S[j] == m) continue;
            auto n = S[j];
            char l;
            if (m != 'R' && n != 'R') {
                l = 'R';
            } else if (m != 'G' && n != 'G') {
                l = 'G';
            } else {
                l = 'B';
            }
            r += MEMO[N-1][idx(l)] - MEMO[i][idx(l)];
            if (i + (i-j) < N && S[i + (i-j)] == l) r -= 1;
        }
    }
    writeln(r);
}