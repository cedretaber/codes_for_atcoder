import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    double s = 0;
    foreach (_; 0..N) {
        auto xu = readln.split;
        auto x = xu[0].to!double;
        if (xu[1] == "JPY") {
            s += x;
        } else {
            s += x * 380000.0;
        }
    }
    writefln("%0.8f", s);
}