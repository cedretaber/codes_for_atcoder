import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rgbn = readln.split.to!(int[]);
    auto R = rgbn[0];
    auto G = rgbn[1];
    auto B = rgbn[2];
    auto N = rgbn[3];

    int ret;
    foreach (r; 0..3001) {
        foreach (g; 0..3001) {
            auto rest = N - R*r - G*g;
            if (rest == 0 || (rest > 0 && rest%B == 0)) ++ret;
        }
    }
    writeln(ret);
}