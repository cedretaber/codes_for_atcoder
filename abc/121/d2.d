import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long solve(long N)
{
    if (N == -1) return 0;
    if (N%2 == 0) {
        return N ^ ((N/2)%2 == 0 ? 0 : 1);
    } else {
        return (N/2)%2 == 1 ? 0 : 1;
    }
}

void main()
{
    auto ab = readln.split.to!(long[]);
    writeln(solve(ab[0]-1) ^ solve(ab[1]));
}