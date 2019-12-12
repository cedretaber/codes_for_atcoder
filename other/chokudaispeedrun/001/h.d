import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    auto DP = [as[0]];
    foreach (a; as[1..$]) {
        if (DP[$-1] < a) {
            DP ~= a;
        } else if (DP[0] >= a) {
            DP[0] = a;
        } else {
            size_t l, r = DP.length - 1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (DP[m] > a) {
                    r = m;
                } else {
                    l = m;
                }
            }
            DP[r] = a;
        }
    }
    writeln(DP.length);
}