import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "x", int, "y");

void main()
{
    auto N = readln.split.to!int;

    auto us = new int[][200001];
    auto rs = new int[][200001];
    auto ds = new int[][200001];
    auto ls = new int[][200001];

    auto ud = new int[][200001];
    auto rd = new int[][200001];
    auto dd = new int[][200001];
    auto ld = new int[][200001];
    foreach (_; 0..N) {
        auto xyu = readln.split;
        auto p = P(xyu[0].to!int, xyu[1].to!int);
        switch (xyu[2]) {
            case "U":
                us[p.x] ~= p.y;
                ud[k] ~= 
                break;
            case "R":
                rs[p.y] ~= p.x;
                break;
            case "D":
                ds[p.x] ~= p.y;
                ds ~= p;
                break;
            case "L":
                ls[p.y] ~= p.x;
                break;
            default:
        }
    }
}