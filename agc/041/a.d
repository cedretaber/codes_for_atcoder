import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nab = readln.split.to!(long[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];

    if ((B-A)%2 == 0) {
        writeln((B-A)/2);
    } else {
        writeln(min(A + (B-A)/2, N-B+1 + (B-A-1)/2));
    }
}