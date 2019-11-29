import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto rb = readln.split.to!(long[]);
    auto R = rb[0];
    auto B = rb[1];
    auto xy = readln.split.to!(long[]);
    auto x = xy[0];
    auto y = xy[1];

    long min_k, max_k = min(R, B)+1;
    while (min_k+1 < max_k) {
        auto k = (min_k + max_k) / 2;
        if ((R-k)/(x-1) + (B-k)/(y-1) >= k) {
            min_k = k;
        } else {
            max_k = k;
        }
    }
    writeln(min_k);
}