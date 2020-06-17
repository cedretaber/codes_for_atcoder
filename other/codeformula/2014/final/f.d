import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.range;

void main()
{
    auto cs = 1.iota(101).array;
    auto xs = new int[](100);
    auto ys = new int[](100);
    int top;
    foreach (k; 0..10) {
        xs[k] = k+1;
        ys[k] = top + k+1;
        top += (k+1)*2;
    }
    top = 0;
    int i = 10, j = 99;
    foreach (s; 0..9) {
        int max_h;
        int left = s == 0 ? 20 : 0;
        foreach (_2; 0..5) {
            auto a = cs[i];
            xs[i] = left + a;
            ys[i] = top + a;
            ++i;

            left += a*2;

            auto b = cs[j];
            xs[j] = left + b;
            ys[j] = top + b;
            --j;

            left += b*2;

            max_h = max(max_h, b*2);
        }
        top += max_h;
    }
    foreach (k; 0..100) writeln(xs[k], " ", ys[k]);
}