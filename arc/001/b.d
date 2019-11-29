import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    int c;
    while (A != B) {
        ++c;
        int a = int.max;
        if ( abs(B-A+10) < abs(B-a)) a = A-10;
        if ( abs(B-A-10) < abs(B-a)) a = A+10;
        if ( abs(B-A+5) < abs(B-a)) a = A-5;
        if ( abs(B-A-5) < abs(B-a)) a = A+5;
        if ( abs(B-A+1) < abs(B-a)) a = A-1;
        if ( abs(B-A-1) < abs(B-a)) a = A+1;
        A = a;
    }
    writeln(c);
}