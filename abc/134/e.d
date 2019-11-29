import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] stk;
    foreach (_; 0..N) {
        auto a = readln.chomp.to!int;
        if (stk.empty || stk[$-1] >= a) {
            stk ~=a;
            continue;
        }
        int l, r = stk.length.to!int-1;
        while (l+1 < r) {
            auto mid = (l+r)/2;
            if (stk[mid] < a) {
                r = mid;
            } else {
                l = mid;
            }
        }
        if (stk[l] < a) {
            stk[l] = a;
        } else {
            stk[r] = a;
        }
    }
    writeln(stk.length);
}