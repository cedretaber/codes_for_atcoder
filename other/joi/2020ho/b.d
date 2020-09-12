import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto S = readln.chomp;

    int[] jj;
    auto lj = new int[](N);
    int idx;
    foreach (i, c; S) if (c == 'J') {
        jj ~= i.to!int;
        lj[i] = jj.length >= K ? jj[idx++] : -1;
    }
    int[] ii;
    auto ri = new int[](N);
    idx = 0;
    int prev = -1;
    foreach_reverse (i, c; S) if (c == 'I') {
        ii ~= i.to!int;
        ri[i] = prev;
        prev = ii.length >= K ? ii[idx++] : -1;
    }

    int jx = -1, ix = prev, count, i, j;
    while (i < N && count < K) {
        if (S[i] == 'O') {
            ++count;
            if (count == K) break;
        } else if (S[i] == 'I') {
            ix = ri[i];
        }
        ++i;
    }
    while (j < N) {
        if (S[j] == 'O') break;
        if (S[j] == 'J') jx = lj[j];
        ++j;
    }
    int res = int.max;
    if (count == K && ix != -1 && jx != -1) res = ix - jx + 1 - K*3;
    while (j < N) {
        while (i < N) {
            ++i;
            if (i == N) break;
            if (S[i] == 'O') {
                ++count;
                break;
            } else if (S[i] == 'I') {
                ix = ri[i];
            }
        }
        --count;
        while (j < N) {
            ++j;
            if (j == N || S[j] == 'O') break;
            if (S[j] == 'J') jx = lj[j];
        }
        if (count == K && ix != -1 && jx != -1) res = min(res, ix - jx + 1 - K*3);
    }
    writeln(res == int.max ? -1 : res);
}