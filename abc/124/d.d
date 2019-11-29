import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5] BS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    size_t i;
    int cnt;
    char fst, lst;
    foreach (j, s; readln.chomp) {
        if (!j) {
            fst = lst = s;
        }
        if (lst != s) {
            BS[i++] = cnt * (lst == '0' ? -1 : 1);
            lst = s;
            cnt = 0;
        }
        ++cnt;
    }
    BS[i] = cnt  * (lst == '0' ? -1 : 1);
    auto len = i+1;

    int max_c, cur;
    i = 0;
    size_t j = 0;
    for (;;) {
        cur += abs(BS[j]);
        if (BS[j] < 0) --K;
        ++j;
        while (i < len && K < 0) {
            cur -= abs(BS[i]);
            if (BS[i] < 0) ++K;
            ++i;
        }
        max_c = max(max_c, cur);
        if (j == len) break;
    }
    writeln(max_c);
}