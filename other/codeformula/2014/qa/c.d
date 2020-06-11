import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    int[][] as;
    int k = K;
    bool[int] memo;
    auto kk = new bool[][](N, K);
    foreach (i; 0..N) {
        as ~= readln.split.to!(int[]);
        int[] bs;
        for (int j; j < k; ++j) {
            auto y = j%N;
            auto x = j/N;
            if (y > i) continue;
            if (as[y][x] in memo) {
                if (!kk[y][x]) ++k;
                kk[y][x] = true;
                continue;
            }
            bs ~= as[y][x];
            memo[as[y][x]] = true;
            kk[y][x] = true;
        }
        sort(bs);
        writeln(bs.to!(string[]).join(" "));
    }
}