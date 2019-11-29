import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto K = nk[1];
    auto S = readln.chomp.to!(char[]);

    size_t[immutable(int[])] MEMO;
    int[26] key;
    auto cs = new char[](K);
    foreach (i, c; S) {
        ++key[c - 'a'];
        if (i < K) {
            cs[i] = c;
            if (i == K-1) MEMO[key.idup] = i;
        } else {
            --key[cs[i%K] - 'a'];
            cs[i%K] = c;
            auto k = key.idup;
            if (k in MEMO && i >= MEMO[k] + K) {
                writeln("YES");
                return;
            } else if (k !in MEMO) {
                MEMO[k] = i;
            }
        }
    }
    writeln("NO");
}