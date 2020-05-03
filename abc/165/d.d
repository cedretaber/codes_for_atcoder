import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abn = readln.split.to!(long[]);
    auto A = abn[0];
    auto B = abn[1];
    auto N = abn[2];

    auto x = min(N, B-1);
    writeln((A*x)/B - A*(x/B));
}