import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    readln;
    auto AS = readln.split.to!(int[]);

    long ret;
    foreach (a; AS) {
        while (!(a&1)) {
            a >>= 1;
            ++ret;
        }
    }
    
    writeln(ret);
}