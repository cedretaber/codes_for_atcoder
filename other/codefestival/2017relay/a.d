import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto kab = readln.split.to!(long[]);
    auto K = kab[0];
    auto A = kab[1];
    auto B = kab[2];
    if (K <= A) {
        writeln(1);
    } else if (A - B <= 0) {
        writeln(-1);
    } else {
        writeln((K-B-1)/(A-B)*2 + 1);
    }
}