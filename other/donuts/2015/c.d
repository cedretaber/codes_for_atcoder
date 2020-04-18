import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto hs = new int[](N);
    int i;
    foreach (h; readln.split.to!(int[])) {
        writeln(i);
        if (i == 0 || hs[i-1] > h) {
            hs[i++] = h;
        } else if (hs[0] <= h) {
            hs[0] = h;
            i = 1;
        } else {
            auto l = 0, r = i-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (hs[m] > h) {
                    l = m;
                } else {
                    r = m;
                }
            }
            hs[r] = h;
            i = r+1;
        }
    }
}