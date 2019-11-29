import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9 + 7;

int[2*10^^5+1] CS;
long[2*10^^5+1] MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        CS[i] = readln.chomp.to!int;
    }

    int[2*10^^5+1] acc, right;
    foreach_reverse(ii, c; CS[0..N]) {
        int i = ii.to!int;
        if (!acc[c]) {
            acc[c] = i;
        } else {
            right[i] = acc[c];
            acc[c] = i;
        }
    }

    foreach_reverse (i; 0..N) {
        if (i == N-1) {
            MEMO[i] = 1;
        } else {
            long r = MEMO[i+1];
            if (right[i] && right[i] != i+1) r = (r + MEMO[right[i]]) % P;
            MEMO[i] = r;
        }
    }

    writeln(MEMO[0]);
}