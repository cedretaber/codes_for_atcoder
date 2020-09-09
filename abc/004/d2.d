import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto rgb = readln.split.to!(int[]);
    auto R = rgb[0];
    auto G = rgb[1];
    auto B = rgb[2];

    int res = int.max;
    foreach (l; -1000..1001) {
        auto r = l+G-1;
        int rr;
        if (l <= -100) {
            rr += R * (R-1) / 2 + R * (-l - 99);
        } else if ((R-1)/2 <= 99+l) {
            auto x = (R-1)/2;
            rr += x * (x+1);
            if (R%2 == 0) rr += x+1;
        } else {
            auto x = 99+l;
            rr += x * (x+1) / 2;
            auto y = R - x - 1;
            rr += y * (y+1) / 2;
        }

        if (r < 0) {
            rr += G * (G-1) / 2 + G * -r;
        } else if (l > 0) {
            rr += G * (G-1) / 2 + G * l;
        } else {
            rr += l * (l-1) / 2 + r * (r+1) / 2;
        }

        if (r >= 100) {
            rr += B * (B-1) / 2 + B * (r - 99);
        } else if ((B-1)/2 <= 99-r) {
            auto x = (B-1)/2;
            rr += x * (x+1);
            if (B%2 == 0) rr += x+1;
        } else {
            auto x = 99-r;
            rr += x * (x+1) / 2;
            auto y = B - x - 1;
            rr += y * (y+1) / 2;
        }
        res = min(res, rr);
    }
    writeln(res);
}