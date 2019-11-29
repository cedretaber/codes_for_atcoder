import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!long-1;
    long i = 1, k = 5;
    while (N) {
        if (N%2 == 1) i = (i*k)%P;
        k = (k^^2)%P;
        N /= 2;
    }
    writeln((i*8)%P);
}