import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto A = readln.chomp.to!(wchar[]);
    auto B = readln.chomp.to!(wchar[]);
    auto C = readln.chomp.to!(wchar[]);

    int r;
    foreach (i; 0..N) {
        auto a = A[i];
        auto b = B[i];
        auto c = C[i];
        if (a == b && b == c) {
        } else if (a == b || b == c || c == a) {
            ++r;
        } else {
            r += 2;
        }
    }
    writeln(r);
}