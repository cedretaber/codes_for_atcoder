import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto md = readln.split.to!(int[]);
    auto M = md[0];
    auto D = md[1];

    int r;
    foreach (m; 0..M) {
        ++m;
        foreach (d; 21..D) {
            ++d;
            if (d%10 >= 2 && d/10 >= 2 && (d%10)*(d/10) == m) {
                ++r;
            }
        }
    }
    writeln(r);
}