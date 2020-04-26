import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto S = readln.chomp;
    int cnt, p;
    int[] as;
    foreach (c; S) {
        auto pp = c == '0' ? -1 : 1;
        if (p != pp) {
            if (p != 0) as ~= cnt * p;
            cnt = 0;
            p = pp;
        }
        ++cnt;
    }
    as ~= cnt * p;
    auto len = as.length;
    size_t i, j;
    int max_s;
    foreach (_; 0..K) {
        if (j == len) break;
        if (as[j] > 0) {
            max_s += as[j++];
        }
        if (j == len) break;
        max_s += -as[j++];
    }
    if (j <= len-1) max_s += as[j++];

    auto s = max_s;
    while (j < len) {
        if (as[i] > 0) s -= as[i++];
        s += as[i++];
        s -= as[j++];
        if (j < len) s += as[j++];
        max_s = max(max_s, s);
    }
    writeln(max_s);
}