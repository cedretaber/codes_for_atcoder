import std.stdio, std.string, std.array, std.conv, std.algorithm;

long solve(long n, long m)
{
    if (2*n > m)
        return m / 2;
    
    auto ret = n;
    m -= n*2;
    ret += m/4;
    return ret;
}

void main()
{
    auto nm = readln.split.to!(long[]);
    writeln(solve(nm[0], nm[1]));
}