import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Box = Tuple!(int, "w", int, "h");

void main()
{
    auto N = readln.chomp.to!int;
    Box[] bs;
    foreach (_; 0..N) {
        auto wh = readln.split.to!(int[]);
        bs ~= Box(wh[0], wh[1]);
    }
    sort!"a.w == b.w ? a.h > b.h : a.w < b.w"(bs);
    int[] lis;
    foreach (b; bs) {
        if (lis.empty || lis[$-1] < b.h) {
            lis ~= b.h;
        } else if (lis[0] >= b.h) {
            lis[0] = b.h;
        } else {
            size_t l, r = lis.length-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (lis[m] >= b.h) {
                    r = m;
                } else {
                    l = m;
                }
            }
            lis[r] = b.h;
        }
    }
    writeln(lis.length);
}