import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;

    int r;
    foreach (i; 0..1000) {
        auto a = i/100;
        auto b = (i/10)%10;
        auto c = i%10;
        int d;
        foreach (j; 0..N) {
            if (d == 0 && S[j] - '0' == a) {
                ++d;
            } else if (d == 1 && S[j] - '0' == b) {
                ++d;
            } else if (d == 2 && S[j] - '0' == c) {
                ++r;
                break;
            }
        }
    }
    writeln(r);
}