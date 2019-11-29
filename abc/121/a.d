import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    hw = readln.split.to!(int[]);
    auto h = hw[0];
    auto w = hw[1];

    writeln(H*W - h*W - w*H + h*w);
}