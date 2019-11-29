import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto whn = readln.split.map!(to!int);
    auto w = whn[0];
    auto h = whn[1];
    auto n = whn[2];

    int t = h, b = 0, l = 0, r = w;

    foreach (_; 0..n) {
        auto xya = readln.split.map!(to!int);
        auto x = xya[0];
        auto y = xya[1];
        auto a = xya[2];

        switch (a) {
            case 1:
                l = l < x ? x : l;
                break;
            case 2:
                r = r > x ? x : r;
                break;
            case 3:
                b = b < y ? y : b;
                break;
            case 4:
                t = t > y ? y : t;
                break;
            default:
        }
    }

    writeln(r <= l || t <= b ? 0 : (r-l)*(t-b));
}