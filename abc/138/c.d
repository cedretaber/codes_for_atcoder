import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    auto vs = readln.split.to!(double[]);
    sort(vs);
    double w = vs[0];
    foreach (v; vs[1..$]) {
        w = (w+v)/2;
    }
    writefln("%.10f", w);
}