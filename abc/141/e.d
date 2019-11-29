import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;

    int min_l, max_l = N/2+1;
    while (min_l+1 < max_l) {
        auto l = (min_l + max_l) / 2;
        int[string] memo;
        bool ok;
        foreach (i; 0..N-l+1) {
            auto k = S[i..i+l];
            if (k in memo) {
                if (memo[k]+l-1 < i) {
                    ok = true;
                    break;
                }
            } else {
                memo[k] = i;
            }
        }
        if (ok) {
            min_l = l;
        } else {
            max_l = l;
        }
    }
    writeln(min_l);
}