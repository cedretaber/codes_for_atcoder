import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    auto ws = readln.split.to!(int[]);
    int ret, l, r;
    foreach (w; ws) r += w;
    ret = abs(l-r);
    foreach (w; ws) {
        r -= w;
        l += w;
        ret = min(ret, abs(l-r));
    }
    writeln(ret);
}