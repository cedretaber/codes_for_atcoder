import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto dln = readln.split.to!(int[]);
    auto D = dln[0];
    long L = dln[1];
    auto N = dln[2];
    auto cs = readln.split.to!(int[]);

    auto last_cs = new int[](10^^5+1);
    last_cs[] = -1;
    auto ls = new int[](D);
    ls[] = -1;
    foreach (i; 0..D) {
        if (last_cs[cs[i]] != -1) {
            auto d = i - last_cs[cs[i]];
            ls[i] = d / L;
            if (d % L == 0) ls[i] -= 1;
        }
        last_cs[cs[i]] = i;
    }
    foreach (i; 0..D) {
        if (ls[i] == -1) {
            auto d = D - (last_cs[cs[i]] - i);
            ls[i] = d / L;
            if (d % L == 0) ls[i] -= 1;
        }
    }

    writeln(ls);
}

/*

ある社員の最初の利用日 F 以降の、一番近い好きな料理の日を探す
-> 料理毎に該当する日を配列で持つ二重配列を作り、好きな料理の日を二分探索する。

タブリングを利用して　2^32 先までの消費日数を記録しておき、これも二分探索で回数を探す。

*/