import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nkc = readln.split.to!(int[]);
    auto N = nkc[0];
    auto K = nkc[1];
    auto C = nkc[2];
    auto S = readln.chomp;
    foreach (_; 0..N) S ~= 'x';
    auto left = new int[](N);
    int last = -1;
    foreach (i; 0..N) {
        left[i] = last;
        if (S[i] == 'o') last = i;
    }

    auto DP1 = new int[](N*2+1);
    foreach (i; 0..N*2) {
        DP1[i+1] = max(DP1[i+1], DP1[i]);
        if (S[i] == 'o') DP1[i+C+1] = max(DP1[i+C+1], DP1[i] + 1);
    }
    auto DP2 = new int[][](2, N*2+1);
    foreach_reverse (i; 0..N*2) {
        if (i-1 >= 0) DP2[0][i-1] = max(DP2[0][i-1], DP2[0][i], DP2[1][i]);
        if (i-C-1 >= 0 && S[i-C-1] == 'o') DP2[1][i-C-1] = max(DP2[1][i-C-1], DP2[0][i]+1, DP2[1][i] + 1);
    }
    foreach (i; 0..N) {
        if (S[i] == 'x') continue;
        if (left[i] == -1) {
            if (DP2[0][i] < K) writeln(i+1);
        } else if (left[i] + C >= i) {
            auto l = left[i];
            if (DP2[1][l] + DP1[l] < K && DP2[0][i] + DP1[i] < K && DP1[i] + DP2[1][i] >= K) writeln(i+1);
        } else {
            if (DP2[0][i] + DP1[i] < K && DP1[i] + DP2[1][i] >= K) writeln(i+1);
        }
    }
}