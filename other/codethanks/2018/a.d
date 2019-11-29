import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto tabcd = readln.split.to!(int[]);
    auto T = tabcd[0];
    auto A = tabcd[1];
    auto B = tabcd[2];
    auto C = tabcd[3];
    auto D = tabcd[4];

    int p;
    if (T >= C) {
        T -= C;
        p += D;
    }
    if (T >= A) p += B;
    
    writeln(p);
}