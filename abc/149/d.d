import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto rsp = readln.split.to!(long[]);
    auto r = rsp[0];
    auto s = rsp[1];
    auto p = rsp[2];
    auto T = readln.chomp;

    long add(int i) {
        switch (T[i]) {
            case 'r': return p;
            case 's': return r;
            case 'p': return s;
            default:
        }
        return 0;
    }

    long res;
    foreach (i; 0..K) {
        auto j = i;
        bool added;
        while (j < N) {
            if (j == i) {
                res += add(j);
                added = true;
            } else if (T[j-K] != T[j]) {
                res += add(j);
                added = true;
            } else if (!added) {
                res += add(j);
                added = true;
            } else {
                added = false;
            }
            j += K;
        }
    }

    writeln(res);
}