import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nab = readln.split.to!(long[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];

    if (N <= A) {
        writeln(N);
    } else {
        auto c = N / (A+B);
        writeln(A * c + min(A, N % (A+B)));
    }
}