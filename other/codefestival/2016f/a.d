import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum AB = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".to!(char[]);

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    foreach (i; 0..H) {
        foreach (j, w; readln.split.to!(string[])) {
            if (w == "snuke") {
                writefln("%c%d", AB[j], i+1);
            }
        }
    }
}