import std.stdio, std.string, std.array, std.conv, std.algorithm;

long P = 10^^9+7;

void main()
{
    auto n = readln.chomp.to!long;
    long ret = 1;
    foreach (i; 0..n) {
        ret *= i + 1;
        ret %= P;
    }
    writeln(ret);
}