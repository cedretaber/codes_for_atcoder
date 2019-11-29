import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);

    int cnt, last, d;
    foreach (a; AS) {
        if (last) {
            if (d == 0) {
                if (last > a) {
                    d = -1;
                } else if (last < a) {
                    d = 1;
                }
            } else if ((d == -1 && a > last) || (d == 1 && a < last)) {
                ++cnt;
                d = 0;
            }
        }
        last = a;
    }
    writeln(cnt+1);
}