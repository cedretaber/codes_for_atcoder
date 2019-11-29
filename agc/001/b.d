import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(long[]);
    auto N = nx[0];
    auto X = nx[1];

    if (X*2 == N) {
        writeln(X*3);
    } else if (X*2 < N) {
        writeln(X*3 + N-X + (N-2*X)*(X/(N-2*X)*2-1));
    } else {
        writeln(X + (N-X)*(X / (N-X)));
    }
}