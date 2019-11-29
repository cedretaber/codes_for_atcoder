import std.stdio, std.algorithm, std.conv, std.array, std.string, std.range;

long PRIM = 1000000007;

long fact_modp(long n)
{
    auto fact = n--;
    for (; n > 0; --n)
        fact = (fact*n)%PRIM;
    return fact;
}

void main()
{
    auto nm = readln.chomp.split(" ").map!(to!long);
    auto n = nm[0];
    auto m = nm[1];

    auto xs = readln.chomp.split(" ").map!(to!long);
    auto ys = readln.chomp.split(" ").map!(to!long);

    auto area = (((xs[$-1] - xs[0])%PRIM) * ((ys[$-1] - ys[0])%PRIM))%PRIM;
    

    writeln((area * ml)%PRIM);
}