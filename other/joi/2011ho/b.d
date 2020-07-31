import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias B = Tuple!(int, "c", int, "g");

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    B[] bs;
    foreach (_; 0..N) {
        auto cg = readln.split.to!(int[]);
        bs ~= B(cg[0], cg[1]);
    }
    sort!"a.g == b.g ? a.c > b.c : a.g < b.g"(bs);
    auto ii = new int[](N);
    int to, g = -1;
    foreach_reverse (i, b; bs) {
        if (g != b.g) {
            to = i.to!int+1;
            g = b.g;
        }
        ii[i] = to;
    }
    auto as = new int[](N);
    int a;
    g = -1;
    foreach (i, b; bs) {
        if (b.g == g) {
            ++a;
        } else {
            g = b.g;
            a = 0;
        }
        as[i] = a;
    }

    auto DP = new int[][](N, K);
    foreach (ref dp; DP) dp[] = -1;
    int solve(int i, int k) {
        if (i == N || k == K) return 0;
        if (DP[i][k] == -1) {
            DP[i][k] = max(solve(i+1, k+1) + bs[i].c + as[i] * 2, solve(ii[i], k));
        }
        return DP[i][k];
    }
    writeln(solve(0, 0));
}