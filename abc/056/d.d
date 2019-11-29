import std.stdio, std.conv, std.string, std.array, std.algorithm;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    auto AS = readln.split.to!(long[]);
    sort!"a < b"(AS);

    int cnt;
    foreach (k, a; AS) {
        if (a >= K) continue;
        bool needed;
        auto s = a;
        size_t i, j;
        for (;;) {
            if (s >= K && s - a < K) {
                needed = true;
                break;
            } else if(i == AS.length) {
                break;
            } else if (i == k) {
                ++i;
            } else if (j == k) {
                ++j;
            } else if (s < K) {
                s += AS[i++];
            } else {
                s -= AS[j++];
            }
        }
        if (!needed) ++cnt;
    }
    writeln(cnt);
}