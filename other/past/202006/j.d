import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto cs = new int[](N);

    foreach (a; readln.split.to!(int[])) {
        if (cs[0] < a) {
            writeln(1);
            cs[0] = a;
        } else if (cs[N-1] >= a) {
            writeln(-1);
        } else {
            int l = 0, r = N-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (cs[m] >= a) {
                    l = m;
                } else {
                    r = m;
                }
            }
            writeln(r+1);
            cs[r] = a;
        }
    }
}