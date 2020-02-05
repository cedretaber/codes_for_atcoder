import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    size_t i, j = N-1;
    long r;
    while (i != j) {
        if (AS[i] < AS[j]) {
            r += 1 + AS[i]*2 + AS[i+1];
            AS[i+2] += AS[i] + AS[i+1] + 2;
            i += 2;
        } else {
            r += 1 + AS[j]*2 + AS[j-1];
            AS[j-2] += AS[j] + AS[j-1] + 2;
            j -= 2;
        }
    }
    writeln(r);
}