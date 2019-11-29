import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(ulong[]);

    size_t i, j;
    ulong res, sum = AS[j], xor = AS[j];
    while (i < N)
    {
        if (sum == xor && j < N)
        {
            if (++j == N)
                continue;
            sum += AS[j];
            xor ^= AS[j];
        }
        else
        {
            res += j - i;
            sum -= AS[i];
            xor ^= AS[i];
            ++i;
        }
    }

    writeln(res);
}
