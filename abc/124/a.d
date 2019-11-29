import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    int r;
    foreach (_; 0..2) {
        if (A > B) {
            r += A;
            --A;
        } else {
            r += B;
            --B;
        }
    }
    writeln(r);
}