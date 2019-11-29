import std.stdio, std.algorithm, std.conv, std.array, std.range, std.string, std.math, std.typecons;

auto mknm()
{
    int[100001] ret;
    int cnt;
    foreach (i; 10000..100000) {
        auto s = i.to!(wchar[]);
        auto pal = true;
        foreach (j; 0..2) if (s[j] != s[4-j]) pal = false;
        if (pal) ++cnt;
        ret[i] = cnt;
    }
    return ret;
}

enum NM = mknm();

void main()
{
    auto ab = readln.split.to!(int[]);
    writeln(NM[ab[1]] - NM[ab[0]-1]);
}