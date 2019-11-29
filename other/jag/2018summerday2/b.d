import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    int r;
    foreach (a; 0..5) {
        foreach (b; 0..2) {
            foreach (c; 0..5) {
                foreach (d; 0..2) {
                    if (N - (a+b+c+d) >= 0) ++r;
                }
            }
        }
    }
    writeln(r);
}