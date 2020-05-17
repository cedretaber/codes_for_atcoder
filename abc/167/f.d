import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias B = Tuple!(int, "in_cnt", int, "out_cnt");

void main()
{
    auto N = readln.chomp.to!int;
    B[] as, bs;
    foreach (_; 0..N) {
        bool fst;
        int cnt, min_cnt;
        foreach (c; readln.chomp) {
            if (c == ')') {
                --cnt;
            } else {
                ++cnt;
            }
            min_cnt = min(min_cnt, cnt);
        }
        if (cnt > 0) {
            as ~= B(min_cnt, cnt - min_cnt);
        } else {
            bs ~= B(min_cnt, cnt - min_cnt);
        }
    }
    sort!"a.in_cnt == b.in_cnt ? a.out_cnt > b.out_cnt : a.in_cnt > b.in_cnt"(as);
    sort!"a.out_cnt == b.out_cnt ? a.in_cnt > b.in_cnt : a.out_cnt > b.out_cnt"(bs);

    int x;
    foreach (a; as) {
        if (x + a.in_cnt < 0) {
            writeln("No");
            return;
        }
        x = x + a.in_cnt + a.out_cnt;
    }
    foreach (b; bs) {
        if (x + b.in_cnt < 0) {
            writeln("No");
            return;
        }
        x = x + b.in_cnt + b.out_cnt;
    }

    writeln(x == 0 ? "Yes" : "No");
}