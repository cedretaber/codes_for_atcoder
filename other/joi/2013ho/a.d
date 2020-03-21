import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto xs = readln.split.to!(int[]);
    foreach (i, ref x; xs) if (i%2 == 1) x = x == 1 ? 0 : 1;
    int[] ys;
    int c, l = -1;
    foreach (x; xs) {
        if (x != l) {
            ys ~= c;
            c = 1;
        } else {
            c += 1;
        }
        l = x;
    }
    ys ~= [c, 0];
    int r;
    foreach (i; 1..ys.length-1) {
        r = max(r, ys[i-1] + ys[i] + ys[i+1]);
    }
    writeln(r);
}