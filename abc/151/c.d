import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    string[][] PS;
    PS.length = N;
    foreach (_; 0..M) {
        auto ps = readln.split;
        PS[ps[0].to!int - 1] ~= ps[1];
    }
    int wa, ac;
    foreach (ss; PS) {
        int ww;
        foreach (s; ss) {
            if (s == "WA") {
                ++ww;
            } else {
                wa += ww;
                ac += 1;
                break;
            }
        }
    }
    writefln("%d %d", ac, wa);
}