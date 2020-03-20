import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abx = readln.split.to!(double[]);
    auto a = abx[0];
    auto b = abx[1];
    auto x = abx[2]/a;

    double th;
    if (x > a*b/2) {
        th = atan((a*b-x)*2/(a^^2)) * (180.0)/PI;
    } else {
        th = 90.0 - atan(x*2/(b^^2)) * (180.0)/PI;
    }
    writefln("%.10f", th);
}