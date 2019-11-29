import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmxy = readln.split.to!(int[]);
    auto X = nmxy[2];
    auto Y = nmxy[3];
    auto xs = readln.split.to!(int[]);
    auto ys = readln.split.to!(int[]);

    int xmax = int.min, ymin = int.max;
    foreach (x; xs) xmax = max(xmax, x);
    foreach (y; ys) ymin = min(ymin, y);

    foreach (z; X..Y) {
        ++z;
        if (xmax < z && ymin >= z) {
            writeln("No War");
            return;
        }
    }
    writeln("War");
}