import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nab = readln.split.to!(long[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];
    auto DS = [0L];
    if (B > 0) DS ~= readln.split.to!(long[]);
    sort!"a < b"(DS);
    foreach (i, d; DS) {
        if (i == DS.length-1) {
            B += (N-d) / A;
        } else {
            B += (DS[i+1] - d - 1) / A;
        }
    }
    writeln(N - B);
}