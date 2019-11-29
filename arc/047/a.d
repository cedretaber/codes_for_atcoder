import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nl = readln.split.to!(int[]);
    auto L = nl[1];
    auto S = readln.chomp.to!(char[]);
    int t = 1, k;
    foreach (c; S) {
        if (c == '+') {
            ++t;
            if (t > L) {
                t = 1;
                ++k;
            }
        } else {
            --t;
        }
    }
    writeln(k);
}