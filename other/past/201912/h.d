import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii;

void main()
{
    auto N = readln.chomp.to!int;
    auto CS = readln.split.to!(int[]);

    int odd_min = int.max, all_min = int.max, odd_a, all_a;
    auto as = new int[](N);
    foreach (i, c; CS) {
        all_min = min(all_min, c);
        if (i%2 == 0) odd_min = min(odd_min, c);
    }

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto s = readln.split.to!(int[]);
        auto a = s[1];
        switch (s[0]) {
            case 1:
                auto x = a-1;
                a = s[2];
                auto res = CS[x] - as[x] - all_a - (x%2 == 0 ? odd_a : 0) - a;
                if (res >= 0) {
                    as[x] += a;
                    all_min = min(all_min, res);
                    if (x%2 == 0) odd_min = min(odd_min, res);
                }
                break;
            case 2:
                if (odd_min >= a) {
                    odd_a += a;
                    odd_min -= a;
                    all_min = min(all_min, odd_min);
                }
                break;
            case 3:
                if (all_min >= a) {
                    all_a += a;
                    all_min -= a;
                    odd_min -= a;
                }
                break;
            default:
        }
    }

    long r;
    foreach (i; 0..N) {
        r += as[i] + all_a + (i%2 == 0 ? odd_a : 0);
    }
    writeln(r);
}