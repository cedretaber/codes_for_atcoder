import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp;
    switch (N[$-1]) {
        case '3': writeln("bon"); return;
        case '0':
        case '1':
        case '6':
        case '8': writeln("pon"); return;
        default: writeln("hon"); return;
    }
}