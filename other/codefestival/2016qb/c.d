import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto wh = readln.split.to!(int[]);
    auto W = wh[0];
    auto H = wh[1];
    auto ps = new long[](W);
    foreach (i; 0..W) ps[i] = readln.chomp.to!long;
    auto qs = new long[](H);
    foreach (i; 0..H) qs[i] = readln.chomp.to!long;
    sort(ps);
    sort(qs);
    auto w = W+1, h = H+1;
    long r;
    size_t i, j;
    while (i < W || j < H) {
        if (j >= H || i < W && ps[i] < qs[j]) {
            r += h * ps[i++];
            if (w > 1) --w;
        } else {
            r += w * qs[j++];
            if (h > 1) --h;
        }
    }
    writeln(r);
}