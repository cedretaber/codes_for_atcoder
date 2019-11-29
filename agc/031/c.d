import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

ulong to_g(ulong n)
{
    return n^(n>>1);
}
 
ulong from_g(ulong n)
{
    n = n^(n>>32);
    n = n^(n>>16);
    n = n^(n>>8);
    n = n^(n>>4);
    n = n^(n>>2);
    n = n^(n>>1);
    return n;
}

int popcount(ulong b)
{
    b = (b & 0x5555555555555555L) + (b >> 1 & 0x5555555555555555L);
    b = (b & 0x3333333333333333L) + (b >> 2 & 0x3333333333333333L);
    b = (b & 0x0f0f0f0f0f0f0f0fL) + (b >> 4 & 0x0f0f0f0f0f0f0f0fL);
    b = (b & 0x00ff00ff00ff00ffL) + (b >> 8 & 0x00ff00ff00ff00ffL);
    b = (b & 0x0000ffff0000ffffL) + (b >>16 & 0x0000ffff0000ffffL);
    b = (b & 0x00000000ffffffffL) + (b >>32 & 0x00000000ffffffffL);
    return b;
}

void main()
{
    auto nab = readln.split.to!(ulong[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];

    if (popcount(A^B) != 0) {
        writeln("NO");
        return;
    }
}