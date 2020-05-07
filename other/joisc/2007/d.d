import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] bs;
    foreach (_; 0..N) bs ~= readln.chomp.to!int;

    auto DP = new int[](N);
    DP[] = int.max;
    foreach (b; bs) {
        if (DP[0] >= b) {
            DP[0] = b;
        } else {
            int l, r = N-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (DP[m] >= b) {
                    r = m;
                } else {
                    l = m;
                }
            }
            DP[r] = b;
        }
    }
    foreach_reverse (i, e; DP) if (e != int.max) {
        writeln(i+1);
        break;
    }
}